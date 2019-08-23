%% MyMainScript
%   The main script for Question 2
tic;
%% Part-(a) Foreground Mask using Thresholding
%
threshold = 15;
[~,~] = myForegroundMask(threshold);
%% Part-(b) Linear Contrast Stretching
%   Contrast stretching isn't effective on the image '../data/church.png'
%   because, our contranst stretching is linear. In linear contrast
%   stretching, one maps the range of intensities in each of the red, blue
%   and green channels to the complete range [0,255]. If it so happens that
%   even one pixel of the channel has a 0 intensity and one pixel has 255
%   intensity, there will be no contrast stretching happening. This can be
%   disadvantageous when we have very few pixel at the extremes of the
%   intensity range - as is the case with the church image.
[image] = imread('../data/barbara.png');
[~] = myLinearContrastStretching(image);
[image] = imread('../data/TEM.png');
[~] = myLinearContrastStretching(image);
[image] = imread('../data/canyon.png');
[~] = myLinearContrastStretching(image);
[image] = imread('../data/church.png');
[~] = myLinearContrastStretching(image);
[image] = imread('../data/chestXray.png');
[~] = myLinearContrastStretching(image);
statue_img = imread('../data/statue.png');
threshold = 15;
mask = (statue_img>threshold);
masked_img = statue_img.*uint8(mask);
[~] = myLinearContrastStretching(masked_img);
%% Part-(c) Histogram Equalization
%   The histogram equalization method used here works better than the
%   linear contrast stretching for the '../data/church.png' image because
%   the histogram equalization method can also perfrom non-linear contrast
%   stretching suitable for the image.
[image] = imread('../data/barbara.png');
[~] = myHE(image);
[image] = imread('../data/TEM.png');
[~] = myHE(image);
[image] = imread('../data/canyon.png');
[~] = myHE(image);
[image] = imread('../data/church.png');
[~] = myHE(image);
[image] = imread('../data/chestXray.png');
[~] = myHE(image);
statue_img = imread('../data/statue.png');
threshold = 15;
mask = (statue_img>threshold);
masked_img = statue_img.*uint8(mask);
[~] = myHE(masked_img);
%% Part-(d) Histogram Matching
%
matched_image = myHM();
%% Part-(e) Contrast-Limited Adaptive Histogram Equalization (CLAHE)
[image] = imread('../data/barbara.png');
[~] = myCLAHE(image, 51, 1.0);
[image] = imread('../data/TEM.png');
[~] = myCLAHE(image, 51, 1.0);
[image] = imread('../data/canyon.png');
[~] = myCLAHE(image, 51, 1.0);
[image] = imread('../data/chestXray.png');
[~] = myCLAHE(image, 51, 1.0);
%%
toc;
