%% MyMainScript
close all;
clear all;
clc;
tic;
%% Your code here
img = imread('../data/grass.png');
[~] = myBilateralFiltering(img, 10, 26, 3);
img = imread('../data/honeycombReal.png')
[~] = myBilateralFiltering(img, 10, 30, 13);
%%
toc;
