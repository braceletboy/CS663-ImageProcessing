%% MyMainScript
close all;
clc;
tic;
%% Parameters initialization
h_c = 0.05;
h_s = 10;
iterations = 1;
learning_rate = 0.9;
%% Mean shift segmentation
img = imread('../data/flower.png');
segmented_img = myMeanShiftSegmentation(img, learning_rate, iterations, h_s, h_c);
figure;
subplot(1,2,1), imshow(img);
title('Original');
colorbar;
subplot(1,2,2), imshow(segmented_img);
title('Segmented');
colorbar;

%% Reporting the Parameters
fprintf('Gaussian kernel bandwidth for the color feature is %f\n', h_c);
fprintf('Gaussian kernel bandwidth for the spatial feature is %f\n', h_s);
fprintf('no of iterations are %d\n', iterations);

toc;
