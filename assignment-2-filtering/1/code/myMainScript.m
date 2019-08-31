%% MyMainScript
close all;
clear all;
clc;
tic;
%% Your code here
thresh_dist = 50;
img = imread('../data/flower.jpg');
generate_bokeh_mask(img);
% [~] = mySpatiallyVaryingKernel(img, thresh_dist);
% img = imread('../data/bird.jpg');
% generate_bokeh_mask(img);
% [~] = mySpatiallyVaryingKernel(img, thresh_dist);
toc;
