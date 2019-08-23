%% MyMainScript
%   The main script for Question 1
tic;
%% Part-(a) Image Shrinking
%
[~] = myShrinkImageByFactorD(2);
[~] = myShrinkImageByFactorD(3);
%% Part-(b) Image Enlargement using Bilinear Interpolation
%
[~] = myBilinearInterpolation();
%% Part-(c) Image Enlargemetn using Nearest-Neighbor Interpolation
%
[~] = myNearestNeighborInterpolation();
%%
toc;
