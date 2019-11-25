function horizon_mixed = getMergedHorizon(left_overlap_img, ...
                                           right_overlap_img, ...
                                           boundary_cut)
%%
%
horizon_mixed = (boundary_cut.*left_overlap_img) + ((1-boundary_cut).*right_overlap_img);
end




