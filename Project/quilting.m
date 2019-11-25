function quilted_image = quilting(texture_image, patch_size,...
                                  threshold_factor, quilt_multiple,overlap_factor)
%% Perform Image Quilting over the given image.
%
% SYNTAX:
%   quilted_image = quilting(texture_image, patch_size, threshold_factor,
%                            quilt_multiple);
%
% INPUTS:
%   texture_image = The input image.
%   patch_size = The patch size to be extracted.
%   threshold_factor = The thershold factor for random sampling.
%   quilt_multiple = The number of patches in one row or column of quilted
%   image.
%
% OUTPUT:
%   quilted_image = The image after quilting.
%
%% Patches(blocks) extraction
%
non_overlap = 1 - overlap_factor;
patch_set = getSlices(texture_image, patch_size);
rand_patch_ind = randi(size(patch_set, 3)/3);
first_slice = patch_set(:, :, (rand_patch_ind-1)*3 + 1: (rand_patch_ind-1)*3 + 3);
final_size = patch_size*overlap_factor + int64(quilt_multiple*patch_size*(non_overlap));
quilted_image = zeros(final_size, final_size, 3);
quilted_image(1:patch_size, 1:patch_size, :) = first_slice;

%% Raster Scan loop
%

for raster_row = 1:int64(non_overlap*patch_size):final_size-overlap_factor*(patch_size)
    for raster_column = 1:int64(non_overlap*patch_size):final_size-overlap_factor*(patch_size)
        if raster_row==1 && raster_column==1
            continue
        
        elseif raster_row==1
            right_overlap_boundary = (raster_column - 1) + overlap_factor*patch_size;
            left_overlap_patch = quilted_image(...
                                    raster_row:raster_row+patch_size-1,...
                                     raster_column:right_overlap_boundary, :);
            right_patch = getRandomPatchHorizon(left_overlap_patch,...
                                                patch_set,...
                                                threshold_factor);
            right_overlap_patch = right_patch(:,1:patch_size*overlap_factor, :);
            error_patch_2d = getErrorPatch(left_overlap_patch,...
                                        right_overlap_patch);
            [boundary_cut, ~, ~] = getMinCut(error_patch_2d);
            boundary_cut = repmat(boundary_cut, [1, 1, 3]);
            merged_patch = getMergedHorizon(left_overlap_patch,...
                right_overlap_patch, boundary_cut);
            quilted_image(raster_row:raster_row+patch_size-1,...
                raster_column:right_overlap_boundary, :) = merged_patch;
            quilted_image(raster_row:raster_row+patch_size-1,...
                right_overlap_boundary+1:right_overlap_boundary+...
                int64(non_overlap*patch_size), :) = right_patch(:,(patch_size*overlap_factor)+1:end, :);
       
        elseif raster_column==1
            bottom_overlap_boundary = (raster_row - 1) + overlap_factor*patch_size;
            top_overlap_patch = quilted_image(...
                              raster_row:bottom_overlap_boundary,...
                              raster_column:raster_column+patch_size-1, :);
            bottom_patch = getRandomPatchVertical(top_overlap_patch,...
                                                  patch_set,...
                                                  threshold_factor);
            bottom_overlap_patch = bottom_patch(1:patch_size*overlap_factor,:, :);
            error_patch_2d = getErrorPatch(bottom_overlap_patch, ...
                                        top_overlap_patch);
            [boundary_cut, ~, ~] = getMinCut(transpose(error_patch_2d));
            boundary_cut = repmat(boundary_cut, [1, 1, 3]);
            merged_patch = getMergedVertical(top_overlap_patch, ...
                bottom_overlap_patch, permute(boundary_cut, [2, 1, 3]));
            quilted_image(raster_row:bottom_overlap_boundary, ...
                raster_column:raster_column+patch_size-1, :) = merged_patch;
            quilted_image(bottom_overlap_boundary+1:...
                bottom_overlap_boundary+int64(non_overlap*patch_size), ...
                raster_column:raster_column+patch_size-1, :) = ...
                                        bottom_patch((patch_size*overlap_factor)+1:end,:, :);
        else
            
            right_overlap_boundary = (raster_column - 1) + overlap_factor*patch_size;
            overlap_patch = quilted_image(...
                                    raster_row:raster_row+patch_size-1,...
                                     raster_column:raster_column+patch_size-1, :);
            middle_patch = getRandomPatchMiddle(overlap_patch,...
                                                patch_set,...
                                                threshold_factor,overlap_factor);
            right_overlap_patch = middle_patch(:,1:patch_size*overlap_factor, :);
            left_overlap_patch = overlap_patch(:,1:patch_size*overlap_factor, :);
            error_patch_2d = getErrorPatch(left_overlap_patch,...
                                        right_overlap_patch);
            [boundary_cut, ~, ~] = getMinCut(error_patch_2d);
            boundary_cut = repmat(boundary_cut, [1, 1, 3]);
            merged_patch = getMergedHorizon(left_overlap_patch,...
                right_overlap_patch, boundary_cut);
            quilted_image(raster_row:raster_row+patch_size-1,...
                raster_column:raster_column+(overlap_factor)*patch_size - 1, :) = merged_patch;
              bottom_overlap_boundary = (raster_row - 1) + overlap_factor*patch_size;
            top_overlap_patch = quilted_image(...
                              raster_row:bottom_overlap_boundary,...
                              raster_column:raster_column+patch_size-1, :);
            bottom_overlap_patch = middle_patch(1:patch_size*overlap_factor,:, :);
            error_patch_2d = getErrorPatch(bottom_overlap_patch, ...
                                        top_overlap_patch);
            [boundary_cut, ~, ~] = getMinCut(transpose(error_patch_2d));
            boundary_cut = repmat(boundary_cut, [1, 1, 3]);
            merged_patch = getMergedVertical(top_overlap_patch, ...
                bottom_overlap_patch, permute(boundary_cut, [2, 1, 3]));
            quilted_image(raster_row:bottom_overlap_boundary, ...
                raster_column:raster_column+patch_size-1, :) = merged_patch;
            
            quilted_image(bottom_overlap_boundary+1:...
                bottom_overlap_boundary+int64(non_overlap*patch_size), ...
                right_overlap_boundary+1:right_overlap_boundary+int64(non_overlap*patch_size), :) = ...
                                       middle_patch((overlap_factor)*patch_size+1:patch_size,(overlap_factor)*patch_size+1:patch_size, :);
            
        end
        
    end
end
end