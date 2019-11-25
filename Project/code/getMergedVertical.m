function [vertical_mixed] = getMergedVertical(top_overlap_img, bottom_overlap_img, boundary_cut)
vertical_mixed = (boundary_cut.*top_overlap_img) + ((1-boundary_cut).*bottom_overlap_img);
end