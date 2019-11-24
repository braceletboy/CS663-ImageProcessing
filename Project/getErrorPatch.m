function error_patch = getErrorPatch(left_overlap_patch, right_overlap_patch)
error_patch = (left_overlap_patch - right_overlap_patch).^2;
end