clear; 
clc;
close all;
tic;
%% Image Quilting
%
% Inputs && parameters
% im2double(imread('../data/bricks.png'));
% patch_size = 60;
% quilt_multiple = 16;
input_image = im2double(imread('../data/windows.png'));
% patch size*overlap_factor must be an integer and patches are square
is_grey = 0;
if(length(size(input_image )) ~= 3)
    input_image = repmat(input_image,[1 1 3]);
    is_grey = 1;
end

overlap_factor = 1/5;
patch_size = 25; 
quilt_multiple = 12;

threshold_factor = 0.1;
quilted_image = quilting(input_image,patch_size,...
                         threshold_factor, quilt_multiple,overlap_factor);
                     
% figure;                     
% if(is_grey == 1)
%     imshow(quilted_image(:, :, 1));
% else
%     disp("hi")
%     imshow(quilted_image);    
% end
%% Texture Transfer
%
% Load Images
texture_image = im2double(imread('../data/rice.png'));
if(length(size(texture_image )) ~= 3)
    texture_image = repmat(texture_image,[1 1 3]);
end
target_image = im2double(imread('../data/potato.png'));
if(length(size(target_image )) ~= 3)
    target_image = repmat(target_image,[1 1 3]);
end

% target_image = target_image(1:144, 1:144, :);
% Inputs and Parameters
% [m, n, ~] =  size(target_image);
overlap_factor = 1/4;
patch_size = 16; %% should be set to
threshold_factor = 0.1;
num_iters = 1;
alpha = 0.6;

%% Main function
transfer_image = texture_transfer(texture_image, target_image,...
                                  patch_size, threshold_factor, num_iters,overlap_factor);
                              
figure;                              
imshow(transfer_image);
toc;