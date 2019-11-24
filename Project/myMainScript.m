clear; 
clc;
tic;
%% Image Quilting
%
% Inputs && parameters
input_image = im2double(imread('data/bricks.png'));
if(length(size(input_image )) ~= 3)
    input_image = repmat(input_image,[1 1 3]);
end
patch_size = 60; % patch size is a multiple of 6 and patches are square
threshold_factor = 0.1;
quilt_multiple = 16;
quilted_image = quilting(input_image, patch_size,...
                         threshold_factor, quilt_multiple);
imshow(quilted_image);
%% Texture Transfer
%
toc