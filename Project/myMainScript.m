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
% Load Images
text_image = double(imread('data/text.jpg'));
bill_image = double(rgb2gray(imread('data/bill.jpg')));
texture_image = text_image;
target_image = bill_image(1:120,1:120);

% Inputs and Parameters
patch_size = 24;
threshold_factor = 0.1;
quilt_multiple = 5;
num_iters = 2;
transfer_image = texture_transfer(text_image, target_image,...
                                  patch_size, threshold_factor,...
                                  quilt_multiple, num_iters);
imshow(transfer_image);
toc