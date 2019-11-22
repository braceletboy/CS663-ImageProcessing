function [error_img] = getError(img1, img2)
[m, ~] = size(img1);
error_img = norm(img1(m , (5/6)*m : m) - img2(m, 1: (m/6))).^2;