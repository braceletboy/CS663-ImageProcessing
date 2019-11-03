function img = patches2img(patch_matrix, img_size)
%%  Return the image given the overlapping patches
%
% SYNTAX:
%   img = patches2img(patch_matrix);
%
% INPUT:
%   patch_matrix = The matrix of patches.
%   img_size = The size of the original image.
%
% OUTPUT:
%   img = The original image from which patches were extracted.
%
%%
%
[num_rows, num_columns] = img_size(:);
img = zeros(img_size);
for row = 1:num_rows-6
    for column = 1:num_columns-6
        count = (row-1)*(num_columns-6) + column;
        patch = patch_matrix(:,count);
        img(row:row+6, column:column+6) = img(row:row+6, column+6) + patch;
    end
end
img = img/49;
end