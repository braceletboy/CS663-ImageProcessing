function filter = generate_bilateral_filter(img, pixel_row, pixel_column,...
    spatial_sigma, intensity_sigma, window_size)
%% Generate the bilateral filter for the given image at the given pixel
%
% SYNTAX:
%   filter = generate_bilateral_filter(img, pixel_x, pixel_y, spatial_sigma, 
%               intensity_sigma, window_size);
%
% INPUT:
%   img = The image whose bilateral filter is required
%   pixel_row = The row of the pixel
%   pixel_column = The column of the pixel
%   spatial_sigma = The sigma for the spatial gaussian
%   intensity_sigma = The sigma for the intensity gaussian
%   window_size = The size of the window over which smoothing is applied
%
% NOTE:
%   window_size is assumed to be an odd number
%
% OUTPUT:
%   filter = The domain filter for the image
%
%%
%
[num_rows, num_columns] = size(img);
top_row = max(1, (pixel_row - (window_size-1)/2));
bottom_row = min(num_rows, (pixel_row + (window_size-1)/2));
left_column = max(1, (pixel_column - (window_size-1)/2));
right_column = min(num_columns, (pixel_column + (window_size-1)/2));
row_diff = (top_row:bottom_row) - pixel_row;
vertical_dist_matrix = repmat(row_diff',1, right_column - left_column+1); 
column_diff = (left_column:right_column) - pixel_column;
horizontal_dist_matrix = repmat(column_diff, bottom_row - top_row+1, 1);
squared_dist_matrix = vertical_dist_matrix.^2 + horizontal_dist_matrix.^2;
squared_intensity_matrix = (img(top_row:bottom_row, ...
    left_column:right_column) - img(pixel_row, pixel_column)).^2;
filter = exp(-1*(squared_dist_matrix/spatial_sigma^2) - ...
    (squared_intensity_matrix/intensity_sigma^2));
end
