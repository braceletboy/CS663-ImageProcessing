function segmented_img = myMeanShiftSegmentation(learning_rate, ...
    num_iter, space_sigma, intensity_sigma)
%% Perform Mean Shift Segmentation
%
% SYNTAX:
%   myMeanShiftSegmentation(learning_rate, bandwidth, num_iter)
%
% INPUTS:
%   learning_rate = The rate of gradient descent
%   bandwidth = The standard deviation of the gaussian
%   num_iter = The number of iterations for gradient ascent
%   num_neighbours = The number of neighbours for knnsearch used in the
%   algo
%
%%
%
img = imread('../data/flower.png');
img = double(img);
%img = img(1:2:end, 1:2:end); % downsample
[num_rows, num_columns, num_channels] = size(img);
updated_img = img;
for iter=1:num_iter
    tic;
    disp('Iter');
    feature_matrix = updated_img;
    row_coordinates = 1:num_rows;
    row_coordinate_matrix = repmat(row_coordinates', 1, num_columns);
    column_coordinates = 1:num_columns;
    column_coordinate_matrix = repmat(column_coordinates, num_rows, 1);
    feature_matrix(:,:, num_channels + 1) = row_coordinate_matrix;
    feature_matrix(:,:, num_channels + 2) = column_coordinate_matrix;
    updated_feature_matrix = gradient_update(feature_matrix, learning_rate, ...
        space_sigma, intensity_sigma);
    updated_img = updated_feature_matrix(:,:,1:3);
    toc;
end
segmented_img = updated_img;
end

function updated_feature_matrix = gradient_update(feature_matrix, ...
    learning_rate, space_sigma, intensity_sigma)
%% Perform gradient update on the given image.
%
%%
%
updated_feature_matrix = feature_matrix;
[num_rows, num_columns, ~] = size(feature_matrix);
for row=1:num_rows
    for column=1:num_columns
        window = 2*space_sigma;
        top_row = max(1, row-window);
        bottom_row = min(num_rows, row+window);
        left_column = max(1, column-window);
        right_column = min(num_columns, column+window);
        feature = feature_matrix(row, column, :);
        % we ignore feature outside row-2*sigma and row+2*sigma window
        nearest_features = feature_matrix(top_row:bottom_row, ...
            left_column:right_column, :);
        space_diff = nearest_features(:,:,4:5) - feature(:,:,4:5);
        intensity_diff = nearest_features(:,:,1:3) - feature(:,:,1:3);
        kernel_matrix = exp(-1*sum(space_diff.^2, 3)/space_sigma^2 -...
            sum(intensity_diff.^2, 3)/intensity_sigma^2);
        gradient = (sum(sum(bsxfun(@times, nearest_features, ...
            kernel_matrix),1),2))/sum(kernel_matrix, 'all') - feature;
        updated_feature_matrix(row,column, :) = feature + ...
            learning_rate*gradient;
    end
end
end