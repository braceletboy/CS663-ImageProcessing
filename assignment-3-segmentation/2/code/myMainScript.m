%% MyMainScript
clear all;
close all;
clc;
tic;
%% Your code here
segmented_img = myMeanShiftSegmentation(0.1, 11, 25, 4);
figure;
subplot(1,2,1), imagesc(img);
title('Original');
colorbar;
subplot(1,2,2), imagesc(segmented_img);
title('Segmented');
colorbar;
toc;
