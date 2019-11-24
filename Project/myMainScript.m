clear; 
clc;
tic;
%% Image Quilting
%
% Inputs && parameters
input_image = im2double(imread('data/t2.png'));
is_grey = 0;
if(length(size(input_image )) ~= 3)
    is_grey = 1;
    input_image = repmat(input_image,[1 1 3]);
end
patch_size = 54; % patch size is a multiple of 6 and patches are square
threshold_factor = 0.1;
quilt_multiple = 16;
quilted_image = quilting(input_image, patch_size,...
                         threshold_factor, quilt_multiple);
if(is_grey == 1)
    imshow(quilted_image(:, :, 1));
else
    imshow(quilted_image);    
end
%% Texture Transfer
%
toc