function output_image = mySpatiallyVaryingKernel(img, mask, kr_img)
%% Apply the Spatially varying averaging disk filter to the given image
%
% SYNTAX:
%   blurred_img = mySpatiallyVaryingKernel(img)
%
% INPUT:
%   img = The input image
%
% OUTPUT:
%   blurred_img = The image with the blurred background and non-blurred
%   foreground
%
%%
%
[num_rows, num_columns, ~] = size(img);
output_image = img;

for row = 1:num_rows
    for column = 1:num_columns
        if mask(row, column) == 0
            kernel_radius = kr_img(row, column);
            kernel = fspecial('disk', kernel_radius); % kernel(square) size is 2*r+1
            kernel_radius = double(uint8(kernel_radius));
            top_row = max(1, row-kernel_radius);
            bottom_row = min(num_rows, row+kernel_radius);
            left_column = max(1, column-kernel_radius);
            right_column = min(num_columns, column+kernel_radius);
            patch = double(img(top_row:bottom_row, left_column:right_column, :));
            cropped_kernel = kernel(1:(bottom_row-top_row+1), 1:(right_column-left_column+1));
            cropped_kernel = cropped_kernel/sum(sum(cropped_kernel));
            output_image(row, column, :) = sum(sum(bsxfun(@times, patch, cast(cropped_kernel, 'like', patch))));            
        end
    end
end

figure;
sgtitle('Part (c) - (iv) Spatially varying blurring');
subplot(1,2,1), imshow(img);
title('Original Image');
colorbar;
subplot(1,2,2), imshow(output_image);
title('Output Image');
colorbar;
end