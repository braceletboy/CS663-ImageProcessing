function [corrupted_img, smoothed_img] = myPatchBasedFiltering(img, sigma, window_size, patch_size)

%% Apply Patch Based Filtering on the given image
%
% INPUT:
%   img = The image on which patch based filtering is to be applied
%   sigma = The sigma for the gaussian
%   window_size = The size of the window of the neighbourhood around pixel of consideration(assumed to be odd number)
%   patch_size = the size of the patches that are used to find similarity
% OUTPUT:
%   smoothed_img = The smoothed image after the filtering
%   corrupted_img = The corrupted image used for filtering
%
%% Main code
noise_sigma = 0.05 * range(img,'all');
noise = randn(size(img))*noise_sigma;
corrupted_img = img + noise;
[num_rows, num_columns] = size(corrupted_img);
smoothed_img = zeros(size(corrupted_img));

% pad the input image with zeroes to  for handlnig boundary conditions
row_zeroes = zeros((patch_size-1)/2, num_columns);
padded_corrupted_img = cat(1, cat(1, row_zeroes, corrupted_img), row_zeroes);
column_zeroes = zeros(num_rows+patch_size-1, (patch_size-1)/2);
padded_corrupted_img = cat(2, cat(2, column_zeroes, padded_corrupted_img), column_zeroes);

for row = 1:num_rows
    for column = 1:num_columns
        
        top_row = max(1, (row - (window_size-1)/2));
        bottom_row = min(num_rows, (row + (window_size-1)/2));
        left_column = max(1, (column - (window_size-1)/2));
        right_column = min(num_columns, (column + (window_size-1)/2));
        
        window = corrupted_img(top_row:bottom_row, left_column:right_column);
        
        filter = generate_patch_based_filter(padded_corrupted_img, row, column, sigma, patch_size,...
            top_row, bottom_row, left_column, right_column, window);
        smoothed_img(row, column) = sum((filter.*window), 'all');
    end
end
end