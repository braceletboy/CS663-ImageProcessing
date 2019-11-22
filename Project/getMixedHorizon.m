function [horizon_mixed] = getMixedHorizon(left_img, right_img,boundary_cut)
[m,~] = size(left_img);
boundary_cut = [ones(m,(5/6)*m) boundary_cut zeros(m,(5/6)*m)];
left_img = [left_img ones(m,(5/6)*m)];
right_img = [ones(m, (5/6)*m) right_img];
horizon_mixed = (boundary_cut.*left_img) + ((1-boundary_cut).*right_img);




