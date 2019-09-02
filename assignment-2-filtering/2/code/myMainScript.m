%% MyMainScript
close all;
clear all;
clc;
tic;
%% Your code here
img = imread('../data/grass.png');
[~] = myBilateralFiltering(img, 10, 10, 11);
%%
toc;
