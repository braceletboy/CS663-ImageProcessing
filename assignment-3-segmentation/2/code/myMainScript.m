%% MyMainScript
clear all;
close all;
clc;
tic;
%% Parameters initialization
img = imread('../data/flower.png');

h_c = 0.05;
h_s = 10;
iterations = 5;
learning_rate = 0.9;
%% Mean shift segmentation
segmented_img = myMeanShiftSegmentation(learning_rate, iterations, h_s, h_c);
figure;
subplot(1,2,1), imagesc(img);
title('Original');
colorbar;
subplot(1,2,2), imagesc(uint8(segmented_img));
title('Segmented');
colorbar;

%% Reporting the Parameters
fprintf('Gaussian kernel bandwidth for the color feature is %f\n', h_c);
fprintf('Gaussian kernel bandwidth for the spatial feature is %f\n', h_s);
fprintf('no of iterations are %d\n', iterations);

toc;
