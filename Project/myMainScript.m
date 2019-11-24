clear; 
clc;
tic;
%% Image Quilting
%
% Inputs && parameters
input_image = imread('data/t6.png');
patch_size = 36; % patch size is a multiple of 6 and patches are square
threshold_factor = 0.1;
quilt_multiple = 12;
texture_image = rgb2hsv(input_image);
texture_image = texture_image(:,:,3);
quilted_image = quilting(texture_image, patch_size,...
                         threshold_factor, quilt_multiple);
imshow(quilted_image);
%% Texture Transfer
%
toc