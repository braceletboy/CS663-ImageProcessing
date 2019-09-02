%% MyMainScript
close all;
clear all;
clc;
tic;
%% Your code here
img1 = load('../data/barbara.mat');
img = double(img1.imageOrig);
[~] = myBilateralFiltering(img, 0.99, 24.2, 57);
img = imread('../data/grass.png');
[~] = myBilateralFiltering(img, 7, 42, 3);
img = imread('../data/honeycombReal.png');
[~] = myBilateralFiltering(img, 2.2, 44, 13);
%%
toc;
