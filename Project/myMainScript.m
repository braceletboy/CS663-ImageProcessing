clear; 
clc;
tic;
%% Image Quilting
%
% Inputs && parameters
% input_image = im2double(imread('data/bricks.png'));
% if(length(size(input_image )) ~= 3)
%     input_image = repmat(input_image,[1 1 3]);
% end
% patch_size = 60; % patch size is a multiple of 6 and patches are square
% threshold_factor = 0.1;
% quilt_multiple = 16;
% quilted_image = quilting(input_image, patch_size,...
%                          threshold_factor, quilt_multiple);
% imshow(quilted_image);
%% Texture Transfer
%
% Load Images
texture_image = im2double(imread('data/bricks.png'));
if(length(size(texture_image )) ~= 3)
    texture_image = repmat(texture_image,[1 1 3]);
end
target_image = im2double(imread('data/t2.png'));
if(length(size(target_image )) ~= 3)
    target_image = repmat(target_image,[1 1 3]);
end

% Inputs and Parameters
patch_size = 60;
threshold_factor = 0.1;
num_iters = 1;
transfer_image = texture_transfer(texture_image, target_image,...
                                  patch_size, threshold_factor, num_iters);
imshow(transfer_image(:,:,1));
toc