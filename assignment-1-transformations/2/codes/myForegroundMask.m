function [mask, masked_img] = myForegroundMask(threshold)
%% Calculate the Foreground Mask of the 2/data/statue.png image
%
% SYNTAX:
%   [mask, masked_img] = myForegroundMask(threshold)
%
% INPUT:
%   threshold = The threshold for considering a pixel as background
%
% OUTPUT:
%   mask = The Foreground mask as a matrix
%   masked_img = The image after apply the mask
%
%%
%
statue_img = imread("../data/statue.png");
mask = (statue_img>threshold);
masked_img = statue_img.*uint8(mask);
figure;
subplot(1,3,1), imshow(statue_img);
title('Original');
colorbar;
subplot(1,3,2), imshow(mask);
title('Mask');
colorbar;
subplot(1,3,3), imshow(masked_img);
title('Masked Image');
colorbar;
end