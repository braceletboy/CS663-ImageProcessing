function [vertical_mixed] = getMixedVertical(up_img, down_img,boundary_cut)
vertical_mixed = getMixedHorizon(up_img.' , down_img.' , boundary_cut.').';