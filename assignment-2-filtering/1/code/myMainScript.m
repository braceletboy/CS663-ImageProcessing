%% MyMainScript
close all;
clear all;
clc;
tic;
%% Your code here
thresh_dist = 20;
img = imread('../data/flower.jpg');
% mask = generate_bokeh_mask(img);
display_kernels(thresh_dist)
% get_kernel_radius(mask, thresh_dist)
% [~] = mySpatiallyVaryingKernel(img, thresh_dist);
% img = imread('../data/bird.jpg');
% generate_bokeh_mask(img);
% [~] = mySpatiallyVaryingKernel(img, thresh_dist);
toc;
