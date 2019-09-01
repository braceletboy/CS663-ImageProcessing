%% MyMainScript
close all;
clear all;
clc;
tic;
%% 1.Flower Image
thresh_dist = 20;
img = imread('../data/flower.jpg');

%% Mask and Masked Images
mask = generate_bokeh_mask(img);

%% Contour Plot of Kernel radius
kr_img = get_kernel_radius(mask, thresh_dist);

%% Displaying kernels for different distances
display_kernels(thresh_dist);

%% Blurring the Background
[~] = mySpatiallyVaryingKernel(img, mask, kr_img);

%% 1.Bird Image
thresh_dist = 40;
img = imread('../data/bird.jpg');

%% Mask and Masked Images
mask = generate_bokeh_mask(img);

%% Contour Plot of Kernel radius
kr_img = get_kernel_radius(mask, thresh_dist);

%% Displaying kernels for different distances
display_kernels(thresh_dist);

%% Blurring the Background
[~] = mySpatiallyVaryingKernel(img, mask, kr_img);
toc;
