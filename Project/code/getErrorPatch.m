function error_patch = getErrorPatch(left_overlap_patch, right_overlap_patch)
left_2d = rgb2gray(left_overlap_patch);
right_2d = rgb2gray(right_overlap_patch);
error_patch = (left_2d - right_2d).^2;
end