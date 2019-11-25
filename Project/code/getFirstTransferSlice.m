function random_patch = getFirstTransferSlice(target_patch, patch_set, threshold_factor)
%%
%
%%
%
num_blocks = int64(size(patch_set, 3)/3);
correspondence_errors = zeros(num_blocks, 1); % column matrix
for idx = 1:num_blocks
    current_patch = patch_set(:, :, (idx-1)*3+1:(idx-1)*3+3);
    correspondence_errors(idx) = sumsqr(current_patch - target_patch);
end
min_error = min(correspondence_errors);
[row_idxs, ~] = find(correspondence_errors <= (1+threshold_factor)*min_error);
idx = datasample(row_idxs, 1);
random_patch = patch_set(:, :, (idx-1)*3+1:(idx-1)*3+3);
end
