function random_patch = getTransferRandomPatchVertical(top_overlap_patch,...
                                                       target_patch,...
                                                       patch_set,...
                                                       threshold_factor,...
                                                       alpha)
%%
%
%%
%
num_blocks = int64(size(patch_set, 3)/3);
[overlap_size, ~, ~] = size(top_overlap_patch);
overlap_errors = zeros(num_blocks, 1); % column matrix
correspondence_errors = zeros(num_blocks, 1); % column matrix
for idx = 1:num_blocks
    current_patch = patch_set(:, :, (idx-1)*3+1:(idx-1)*3+3);
    correspondence_errors(idx) = sumsqr(current_patch - target_patch);
    overlap_errors(idx) = sum((current_patch(1:overlap_size,:,:) - ...
                                 top_overlap_patch).^2,'all');
end
overall_errors = alpha*correspondence_errors + (1-alpha)*overlap_errors;
min_error = min(overall_errors);
[row_idxs, ~] = find(overall_errors<(1+threshold_factor)*min_error);
idx = datasample(row_idxs, 1);
random_patch = patch_set(:, :, (idx-1)*3+1:(idx-1)*3+3);
end