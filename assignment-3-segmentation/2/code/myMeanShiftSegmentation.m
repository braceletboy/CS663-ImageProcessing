function myMeanShiftSegmentation(learning_rate, bandwidth, num_iter,...
    num_neighbours)
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
img = img(1:10:end, 1:10:end); % downsample
[num_rows, num_columns, num_channels] = size(img);
updated_img = img;
for iter=1:num_iter
    disp('Iter');
    feature_matrix = updated_img;
    row_coordinates = 1:num_rows;
    row_coordinate_matrix = repmat(row_coordinates', 1, num_columns);
    column_coordinates = 1:num_columns;
    column_coordinate_matrix = repmat(column_coordinates, num_rows, 1);
    feature_matrix(:,:, num_channels + 1) = row_coordinate_matrix;
    feature_matrix(:,:, num_channels + 2) = column_coordinate_matrix;
    updated_feature_matrix = gradient_update(feature_matrix, learning_rate, ...
        bandwidth, num_neighbours);
    updated_img = updated_feature_matrix(:,:,1:3);
end
figure;
subplot(1,2,1), imagesc(img);
title('Original');
colorbar;
subplot(1,2,2), imagesc(updated_img);
title('Segmented');
colorbar;
end

function updated_feature_matrix = gradient_update(feature_matrix, ...
    learning_rate, bandwidth, num_neighbours)
%% Perform gradient update on the given image.
%
%%
%
updated_feature_matrix = feature_matrix;
[num_rows, num_columns, num_channels] = size(feature_matrix);
for channel=1:num_channels
    channel_matrix = squeeze(feature_matrix(:,:,channel));
    channel_matrix = channel_matrix(:);
    
end
for row=1:num_rows
    for column=1:num_columns
        feature = feature_matrix(row, column, :);
        nearest_features = get_nearest_features(feature_matrix, feature,...
            num_neighbours);
        feature = transpose(squeeze(feature));
        feature_kernel_matrix = exp(sum((nearest_features - feature).^2,...
            2)/bandwidth^2);
        gradient = (sum(bsxfun(@times, nearest_features, ...
            feature_kernel_matrix)))/sum(feature_kernel_matrix) - feature;
        updated_feature_matrix(row,column, :) = feature + ...
            learning_rate*gradient;
    end
end
end

function nearest_features = get_nearest_features(feature_matrix, ...
    feature, num_neighbours)
%% Return the nearest features to the given feature from the feature space.
%
%%
%
feature_matrix = permute(feature_matrix, [3 1 2]);
feature_matrix = transpose(feature_matrix(:,:));
feature = transpose(squeeze(feature));
indices = knnsearch(feature_matrix, feature, 'K', num_neighbours);
nearest_features = feature_matrix(indices, :);
end