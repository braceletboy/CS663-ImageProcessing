%% MyMainScript
clear all;
close all;
clc;
tic;
%% Parameters initialization
h_c = 0.05;
h_s = 10;
iterations = 20;
%% Mean shift segmentation
segmented_img = myMeanShiftSegmentation(0.1, 11, 25, 4);
figure;
subplot(1,2,1), imagesc(img);
title('Original');
colorbar;
subplot(1,2,2), imagesc(segmented_img);
title('Segmented');
colorbar;

%% Reporting the Parameters
fprintf('Gaussian kernel bandwidth for the color feature is %f\n', h_c);
fprintf('Gaussian kernel bandwidth for the spatial feature is %f\n', h_s);
fprintf('no of iterations are %d\n', iterations);

toc;
