%% MyMainScript
close all;
clear all;
clc;
tic;
%% Your code here
% img1 = load('../data/barbara.mat');
% img = double(img1.imageOrig);
% [~] = myBilateralFiltering(img, 0.9, 25, 57);
% img = imread('../data/grass.png');
% [~] = myBilateralFiltering(img, 7, 26, 3);
img = imread('../data/honeycombReal.png');
[~] = myBilateralFiltering(img, 1.8, 30, 13);
%%
toc;
