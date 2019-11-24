function random_patch = getTransferRandomPatchMiddle(overlap_patch,...
                                                     target_patch,...
                                                     patch_set,...
                                                     threshold_factor,...
                                                     alpha)
%%
%
%%
%
num_blocks = int64(size(patch_set, 3)/3);
[~, patch_size, ~] = size(overlap_patch);
overlap_errors = zeros(num_blocks, 1); % column matrix
correspondence_errors = zeros(num_blocks, 1); % column matrix
for idx = 1:num_blocks
    current_patch = patch_set(:, :, (idx-1)*3+1:(idx-1)*3+3);
    correspondence_errors(idx) = sumsqr(current_patch - target_patch);
    current_patch((1/6)*patch_size+1:patch_size,(1/6)*patch_size+1:patch_size, :) = 0;
    overlap_errors(idx) = sum((current_patch - ...
                                 overlap_patch).^2,'all');
end
overall_errors = alpha*correspondence_errors + (1-alpha)*overlap_errors;
min_error = min(overall_errors);
[row_idxs, ~] = find(overall_errors<(1+threshold_factor)*min_error);
idx = datasample(row_idxs, 1);
random_patch = patch_set(:, :, (idx-1)*3+1:(idx-1)*3+3);
end