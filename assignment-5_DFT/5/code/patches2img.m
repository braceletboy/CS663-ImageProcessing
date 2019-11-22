function img = patches2img(patch_matrix, img_size)
%%  Return the image given the overlapping patches
%
% SYNTAX:
%   img = patches2img(patch_matrix);
%
% INPUT:
%   patch_matrix = The matrix of patches.
%   img_size = The size matrix of the original image.
%
% OUTPUT:
%   img = The original image from which patches were extracted.
%
%%
%
num_columns = img_size(2);
num_patches = size(patch_matrix, 2);
img = zeros(img_size);
row = 0;
for idx = 1:num_patches
    column = mod(idx, num_columns-6);
    if column==0
        column = num_columns-6;
    elseif column==1
        row = row + 1;
    end
    patch = reshape(patch_matrix(:,idx), 7, 7);
    img(row:row+6, column:column+6) = (img(row:row+6, column:column+6) ...
                                       + patch);
end
img = img/49;
end