function quilted_image = quilting(texture_image, patch_size,...
                                  threshold_factor, quilt_multiple)
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
patch_set = getSlices(texture_image, patch_size);
first_slice = patch_set(:, :, randi(size(patch_set, 3)));
final_size = patch_size + 5/6*patch_size*(quilt_multiple-1);
quilted_image = zeros(final_size);
quilted_image(1:patch_size, 1:patch_size) = first_slice;

%% Raster Scan loop
%
for raster_row = 1:(5/6*patch_size):final_size-1/6*(patch_size)
    for raster_column = 1:(5/6*patch_size):final_size-1/6*(patch_size)
        if raster_row==1 && raster_column==1
            continue
        
        elseif raster_row==1
            right_overlap_boundary = (raster_column - 1) + 1/6*patch_size;
            left_overlap_patch = quilted_image(...
                                    raster_row:raster_row+patch_size-1,...
                                     raster_column:right_overlap_boundary);
            right_patch = getRandomPatchHorizon(left_overlap_patch,...
                                                patch_set,...
                                                threshold_factor);
            right_overlap_patch = right_patch(:,1:patch_size/6);
            error_patch = getErrorPatch(left_overlap_patch,...
                                        right_overlap_patch);
            [boundary_cut, ~, ~] = getMinCut(error_patch);
            merged_patch = getMergedHorizon(left_overlap_patch,...
                right_overlap_patch, boundary_cut);
            quilted_image(raster_row:raster_row+patch_size-1,...
                raster_column:right_overlap_boundary) = merged_patch;
            quilted_image(raster_row:raster_row+patch_size-1,...
                right_overlap_boundary+1:right_overlap_boundary+...
                5/6*patch_size) = right_patch(:,patch_size/6+1:end);
       
        elseif raster_column==1
            bottom_overlap_boundary = (raster_row - 1) + 1/6*patch_size;
            top_overlap_patch = quilted_image(...
                              raster_row:bottom_overlap_boundary,...
                              raster_column:raster_column+patch_size-1);
            bottom_patch = getRandomPatchVertical(top_overlap_patch,...
                                                  patch_set,...
                                                  threshold_factor);
            bottom_overlap_patch = bottom_patch(1:patch_size/6,:);
            error_patch = getErrorPatch(bottom_overlap_patch, ...
                                        top_overlap_patch);
            [boundary_cut, ~, ~] = getMinCut(transpose(error_patch));
            merged_patch = getMergedVertical(top_overlap_patch, ...
                bottom_overlap_patch, transpose(boundary_cut));
            quilted_image(raster_row:bottom_overlap_boundary, ...
                raster_column:raster_column+patch_size-1) = merged_patch;
            quilted_image(bottom_overlap_boundary+1:...
                bottom_overlap_boundary+5/6*patch_size, ...
                raster_column:raster_column+patch_size-1) = ...
                                        bottom_patch(patch_size/6+1:end,:);
        else
            
            right_overlap_boundary = (raster_column - 1) + 1/6*patch_size;
            overlap_patch = quilted_image(...
                                    raster_row:raster_row+patch_size-1,...
                                     raster_column:raster_column+patch_size-1);
            middle_patch = getRandomPatchMiddle(overlap_patch,...
                                                patch_set,...
                                                threshold_factor);
            right_overlap_patch = middle_patch(:,1:patch_size/6);
            left_overlap_patch = overlap_patch(:,1:patch_size/6);
            error_patch = getErrorPatch(left_overlap_patch,...
                                        right_overlap_patch);
            [boundary_cut, ~, ~] = getMinCut(error_patch);
            merged_patch = getMergedHorizon(left_overlap_patch,...
                right_overlap_patch, boundary_cut);
            quilted_image(raster_row:raster_row+patch_size-1,...
                raster_column:raster_column+(1/6)*patch_size - 1) = merged_patch;
              bottom_overlap_boundary = (raster_row - 1) + 1/6*patch_size;
            top_overlap_patch = quilted_image(...
                              raster_row:bottom_overlap_boundary,...
                              raster_column:raster_column+patch_size-1);
            bottom_overlap_patch = middle_patch(1:patch_size/6,:);
            error_patch = getErrorPatch(bottom_overlap_patch, ...
                                        top_overlap_patch);
            [boundary_cut, ~, ~] = getMinCut(transpose(error_patch));
            merged_patch = getMergedVertical(top_overlap_patch, ...
                bottom_overlap_patch, transpose(boundary_cut));
            quilted_image(raster_row:bottom_overlap_boundary, ...
                raster_column:raster_column+patch_size-1) = merged_patch;
            
            quilted_image(bottom_overlap_boundary+1:...
                bottom_overlap_boundary+5/6*patch_size, ...
                right_overlap_boundary+1:right_overlap_boundary+5/6*patch_size) = ...
                                       middle_patch((1/6)*patch_size+1:patch_size,(1/6)*patch_size+1:patch_size);
            
        end
        
    end
end