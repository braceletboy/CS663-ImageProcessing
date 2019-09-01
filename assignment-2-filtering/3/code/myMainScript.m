%% MyMainScript
close all;
clear all;
clc;
tic;
%% Your code here
img = imread('../data/grass.png');
window_size = 25;
patch_size = 9;
sigma = 150;
[~] = myPatchBasedFiltering(img, sigma, window_size, patch_size);
gaussian_mask = fspecial('gaussian', patch_size, sigma);
figure;
imshow(gaussian_mask, [min(gaussian_mask,[],'all'), max(gaussian_mask,[],'all')], ...
    'InitialMagnification', 800);
title('Mask');
colorbar;
toc;
