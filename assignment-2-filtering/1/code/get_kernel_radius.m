function kr_img = get_kernel_radius(mask, thresh_dist)
%% Return the kernel radius for each pixel of the image
%
% SYNTAX:
%   kr_img = get_kernel_radius(img, mask);
%
% INPUT:
%   mask = The mask of the input image
%   thresh_dist = The threshold distance used for calculating radius
%
% OUTPUT:
%   kr_img = The image with each pixel value having the radius of the
%   correspondingly positioned pixel in the input image
%
%%
%
kr_img = bwdist(mask);
kr_img(kr_img > thresh_dist) = thresh_dist;
figure;
sgtitle('Part (c) - (ii) Contour Plot');
contour(flipud(kr_img));
colorbar;
end