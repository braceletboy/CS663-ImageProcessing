
function random_patch = getRandomPatchHorizon(left_overlap_patch, ...
                                              patch_set, ...
                                              threshold_factor)
%% Return a random similar patch from the set of patches
%
% SYNTAX:
%   random_patch = getRandomPatch(overlap_patch,
%                                 patch_set,
%                                 threshold_factor)
%
% INPUTS:
%   left_overlap_patch = The overlap region from the quilted image.
%   patch_set = The set of all patches.
%   threshold_factor = The threshold for similarity function.
%
%%
%
num_blocks = size(patch_set, 3)/3;
[~, overlap_size, ~] = size(left_overlap_patch);
overlap_errors = zeros(num_blocks, 1); % column matrix
for idx = 1:num_blocks
    current_patch = patch_set(:, :, (idx-1)*3+1:(idx-1)*3+3);
    overlap_errors(idx) = sum((current_patch(:,1:overlap_size, :) - ...
                                 left_overlap_patch).^2,'all');
end
min_error = min(overlap_errors);
[row_idxs, ~] = find(overlap_errors <=(1+threshold_factor)*min_error);
idx = datasample(row_idxs, 1);
random_patch = patch_set(:, :, (idx-1)*3+1:(idx-1)*3+3);
end