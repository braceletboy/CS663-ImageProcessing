function [vertical_mixed] = getMergedVertical(up_img, down_img, boundary_cut)
vertical_mixed = getMergedHorizon(up_img.' , down_img.' , boundary_cut.').';
end