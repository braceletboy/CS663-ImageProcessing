%% MyMainScript
clear all;
close all;
clc;
tic;
%% Your code here
img = imread('../data/flower.png');
segmented_img = myMeanShiftSegmentation(img, 1, 5, 11, 11);
figure;
subplot(1,2,1), imshow(img);
title('Original');
colorbar;
subplot(1,2,2), imshow(segmented_img);
title('Segmented');
colorbar;
toc;
