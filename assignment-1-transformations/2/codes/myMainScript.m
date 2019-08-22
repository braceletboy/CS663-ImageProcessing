%% MyMainScript
%   The main script for Question 2
clear all;
tic;
%% Part-(a)
%
threshold = 15;
% [~,~] = myForegroundMask(threshold);
%% Part-(b)
%   
[image] = imread("../data/barbara.png");
[~] = myLinearContrastStretching(image);
[image] = imread("../data/TEM.png");
[~] = myLinearContrastStretching(image);
[image] = imread("../data/canyon.png");
[~] = myLinearContrastStretching(image);
[image] = imread("../data/church.png");
[~] = myLinearContrastStretching(image);
[image] = imread("../data/chestXray.png");
[~] = myLinearContrastStretching(image);
statue_img = imread("../data/statue.png");
mask = (statue_img>threshold);
masked_img = statue_img.*uint8(mask);
[~] = myLinearContrastStretching(masked_img);
%%
toc;
