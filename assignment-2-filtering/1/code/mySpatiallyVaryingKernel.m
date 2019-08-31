function bokeh_img = mySpatiallyVaryingKernel(img, thresh_dist)
%% Apply the Spatially varying averaging disk filter to the given image
%
% SYNTAX:
%   bokeh_image = mySpatiallyVaryingKernel(img)
%
% INPUT:
%   img = The input image
%
% OUTPUT:
%   bokeh_img = The image with the blurred background and non-blurred
%   foreground
%
%%
%
[num_rows, num_columns, num_channels] = size(img);
mask = generate_bokeh_mask(img);
inverted_mask = (1-mask);
kr_img = get_kernel_radius(mask, thresh_dist);
display_kernels(thresh_dist);
bokeh_img = zeros(size(img));
for channel = 1:num_channels
    img_channel = squeeze(img(:,:,channel));
    for row = 1:num_rows
        for column = 1:num_columns
            kernel_radius = double(kr_img(row, column));
            kernel = fspecial('disk', kernel_radius);% kernel size is 2*r+1
            patch = zeros(size(kernel));
            top_row = max(1, row-kernel_radius);
            bottom_row = min(num_rows, row+kernel_radius);
            left_column = max(1, column-kernel_radius);
            right_column = min(num_columns, column+kernel_radius);
            if (row-kernel_radius<1)
                if (column-kernel_radius<1)
                    patch(2+kernel_radius-row:end, ...
                        2+kernel_radius-column:end) = ...
                        img_channel(top_row:bottom_row, ...
                        left_column:right_column);
                elseif (column+kernel_radius>num_columns)
                    patch(2+kernel_radius-column:end, ...
                        1:end-(column+kernel_radius-num_columns)) = ...
                        img_channel(top_row:bottom_row, ...
                        left_column:right_column);
                else
                    patch(2+kernel_radius-column:end,:) = ...
                        img_channel(top_row:bottom_row, ...
                        left_column:right_column);
                end
            elseif (row+kernel_radius>num_rows)
                if (column-kernel_radius<1)
                    patch(1:end-(row+kernel_radius-num_rows), ...
                        2+kernel_radius-column:end) = ...
                        img_channel(top_row:bottom_row, ...
                        left_column:right_column);
                elseif (column+kernel_radius>num_columns)
                    patch(1:end-(row+kernel_radius-num_rows), ...
                        1:end-(column+kernel_radius-num_columns)) = ...
                        img_channel(top_row:bottom_row, ...
                        left_column:right_column);
                else
                    patch(1:end-(row+kernel_radius-num_rows),:) = ...
                        img_channel(top_row:bottom_row, ...
                        left_column:right_column);
                end
            else
                if (column-kernel_radius<1)
                    patch(:, 2+kernel_radius-column:end) = ...
                        img_channel(top_row:bottom_row, ...
                        left_column:right_column);
                elseif (column+kernel_radius>num_columns)
                    patch(:,1:end-(column+kernel_radius-num_columns)) = ...
                        img_channel(top_row:bottom_row, ...
                        left_column:right_column);
                else
                    patch = img_channel(top_row:bottom_row, ...
                        left_column:right_column);
                end
            end
            bokeh_img(row, column) = sum(sum(patch.*kernel));
        end
    end
end
bokeh_img = double(mask).*img + double(inverted_mask).*bokeh_img;
figure;
sgtitle('Part (c) - Bokeh Effect');
subplot(1,2,1), imshow(img);
title('Original');
colorbar;
subplot(1,2,2), imshow(bokeh_img);
title('Bokeh Image');
colorbar;
end