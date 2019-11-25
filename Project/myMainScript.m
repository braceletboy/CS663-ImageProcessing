clear; 
clc;
tic;
%% Image Quilting
%
% Inputs && parameters
input_image = im2double(imread('data/t4.png'));
is_grey = 0;
if(length(size(input_image )) ~= 3)
    is_grey = 1;
    input_image = repmat(input_image,[1 1 3]);
end

% patch size*overlap_factor must be an integer and patches are square

overlap_factor = 1/4;
patch_size = 24; 
quilt_multiple = 20;

threshold_factor = 0.1;
quilted_image = quilting(input_image,patch_size,...
                         threshold_factor, quilt_multiple,overlap_factor);
if(is_grey == 1)
    imshow(quilted_image(:, :, 1));
else
    imshow(quilted_image);    
end
%% Texture Transfer
%
% Load Images
clc;
clear;
texture_image = im2double(imread('data/rice.png'));
if(length(size(texture_image )) ~= 3)
    texture_image = repmat(texture_image,[1 1 3]);
end
target_image = im2double(imread('data/bill.png'));
if(length(size(target_image )) ~= 3)
    target_image = repmat(target_image,[1 1 3]);
end

target_image = target_image(1:216, 1:216, :);

% Inputs and Parameters
patch_size = 36;
threshold_factor = 0.1;
num_iters = 2;
alpha = 0.6;
transfer_image = texture_transfer(texture_image, target_image,...
                                  patch_size, threshold_factor, num_iters);
imshow(transfer_image);
toc