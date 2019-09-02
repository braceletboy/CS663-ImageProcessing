function filter = generate_patch_based_filter(padded_img, pixel_row, pixel_column, sigma, patch_size, ...
    window_top, window_bottom, window_left, window_right, window)

%% Generate the bilateral filter for the given image at the given pixel
%
% INPUT:
%   padded_img = The padded input image
%   pixel_row = The row of the pixel
%   pixel_column = The column of the pixel
%   sigma = The sigma for the gaussian
%   patch_size = the size of the patches that are used to find similarity
%   window = The window around pixel of consideration
%   window_top, window_bottom, window_left, window_right = boundaries of
%   the window
% OUTPUT:
%   filter = The pattch based filter for the image
%
%%
% Main Code
filter = zeros(size(window));
center_patch = padded_img(pixel_row : pixel_row+patch_size-1, pixel_column : pixel_column+patch_size-1);

for row = window_top : window_bottom
    for column = window_left : window_right
        other_patch = padded_img(row : row+patch_size-1, column : column+patch_size-1);
        filter(row-window_top+1, column-window_left+1) = ...
            exp (-1 * (sum((center_patch - other_patch).^2, 'all')/(sigma^2)));
    end
end
filter = filter/sum(filter, 'all');

end