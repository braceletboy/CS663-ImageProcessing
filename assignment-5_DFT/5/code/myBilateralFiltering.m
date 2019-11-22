function [smoothed_img, corrupted_img, rmse] = myBilateralFiltering(img, ...
    noise_sigma, spatial_sigma, ...
    intensity_sigma, window_size)
%% Apply Bilateral Filtering on the given image
%
% SYNTAX:
%   smoothed_img = myBilateralFiltering(img, spatial_sigma, 
%                   intensity_sigma, window_size);
%
% INPUT:
%   img = The image on which bilateral filtering is to be applied
%   spatial_sigma = The sigma for the spatial gaussian
%   intensity_sigma = The sigma for the intensity gaussian
%   window_size = The size of the window (assumed to be odd number)
%
% OUTPUT:
%   corrupted_img = The noisy image.
%   smoothed_img = The smoothed image after the filtering.
%
%%
%
img = double(img);
noise = randn(size(img))*noise_sigma;
corrupted_img = img + noise;
[num_rows, num_columns] = size(corrupted_img);
smoothed_img = zeros(size(corrupted_img));
for row = 1:num_rows
    for column = 1:num_columns
        filter = generate_bilateral_filter(corrupted_img, row, column, ...
            spatial_sigma, intensity_sigma, window_size);
        top_row = max(1, (row - (window_size-1)/2));
        bottom_row = min(num_rows, (row + (window_size-1)/2));
        left_column = max(1, (column - (window_size-1)/2));
        right_column = min(num_columns, (column + (window_size-1)/2));
        patch = corrupted_img(top_row:bottom_row, left_column:right_column);
        smoothed_img(row, column) = sum(sum((filter.*patch)))/...
            sum(sum(filter));
    end
end
rmse = sumsqr(smoothed_img - img)/sumsqr(img);
end