function filter = generate_patch_based_filter(padded_img, pixel_row, pixel_column, sigma, patch_size, ...
    window_top, window_bottom, window_left, window_right, window)

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