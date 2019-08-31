%% MyMainScript
close all, clear all, clc;
tic;
%% Your code here
thresh_dist = 50;
img = imread('../data/flower.jpg');
[~] = mySpatiallyVaryingKernel(img, thresh_dist);
% img = imread('../data/bird.jpg');
% [~] = mySpatiallyVaryingKernel(img, thresh_dist);
toc;
