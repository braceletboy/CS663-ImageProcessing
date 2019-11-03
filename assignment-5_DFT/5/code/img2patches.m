function patch_matrix = img2patches(img)
%% Return 7x7 patches for the given image.
%
% SYNTAX:
%   patch_matrix = img2patches(img, num_patches)
%
% INPUTS:
%   img = The input image.
%
% OUTPUT:
%   patch_matrix = The matrix of patches with each patch as column vector.
%%
%
[num_rows, num_columns] = size(img);
num_patches = (num_rows-6)*(num_columns-6);
patch_matrix = zeros(49, num_patches);
count = 0;
for row = 1:num_rows-6
    for column = 1:num_columns-6
        patch = img(row:row+6, column:column+6);
        count = count + 1;
        patch_matrix(:,count) = patch(:);
    end
end
end