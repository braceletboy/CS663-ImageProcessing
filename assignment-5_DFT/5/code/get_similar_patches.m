function similar_patches = get_similar_patches(img, row, column, ...
                                               num_similar_patches)
%%  Obtain the similar patches.
%
% SYNTAX:
%   similar_patches = get_similar_patches(img, row, column,
%                                         num_similar_patches);
%
% INPUTS:
%   img = The original image.
%   row = The row corresponding to the ref patch.
%   column = The column corresponding to the ref patch.
%   num_similar_patches = The number of similar patches to consider.
%
% OUTPUT:
%   similar_patches = The collection of similar patches for the given
%   patch.
%
%%
%
[num_rows, num_columns] = size(img);
similar_patches = zeros(49, num_similar_patches);
ref_patch = img(row:row+6, column:column+6);
similar_patches(:,1) = ref_patch(:);
count = 1;
start_row = max([1 row-15]);
end_row = min([row+15+6 num_rows])-6;
start_column = max([1 column-15]);
end_column = min([column+15+6 num_columns])-6;
neighbour_patches = zeros(49, (end_row - start_row)*(start_column - ...
                                                     end_column) - 1);
for r = start_row:end_row
    for c = start_column:end_column
        if (r==row && c==column)
            continue
        end
        patch = img(r:r+6, c:c+6);
        neighbour_patches(:, count) = patch(:);
        count = count + 1;
    end
end
dissimilarity = sum((neighbour_patches-ref_patch(:)).^2);
[~, patch_indices] = mink(dissimilarity, num_similar_patches-1);
similar_patches(:,2:end) = neighbour_patches(:, patch_indices);
end