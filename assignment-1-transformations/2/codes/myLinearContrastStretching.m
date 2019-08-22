function contrast_stretched_img = myLinearContrastStretching(image)
%% Perform Linear Contrast Stretching over the given image
%
% SYNTAX:
%   myLinearContrastStretching(image);
%
% INPUT:
%   image_path = The input image path
%
% OUTPUT:
%   contrast_stretched_img = The image after contrast stretching
%
%% 
%
image = double(image);
if length(size(image))==2
    min_val = min(min(image));
    max_val = max(max(image));
    contrast_stretched_img = uint8((image-min_val)/(max_val-min_val)*255);
    figure;
    subplot(1,2,1), imshow(uint8(image));
    colorbar;
    subplot(1,2,2), imshow(contrast_stretched_img);
    colorbar;
elseif length(size(image))==3
    red_channel = image(:,:,1);
    blue_channel = image(:,:,2);
    green_channel = image(:,:,3);
    red_min = min(min(red_channel));
    red_max = max(max(red_channel));
    blue_min = min(min(blue_channel));
    blue_max = max(max(blue_channel));
    green_min = min(min(green_channel));
    green_max = max(max(green_channel));
    red_channel = (red_channel-red_min)/(red_max-red_min);
    blue_channel = (blue_channel-blue_min)/(blue_max-blue_min);
    green_channel = (green_channel-green_min)/(green_max-green_min);
    contrast_stretched_img = zeros(size(image));
    contrast_stretched_img(:,:,1) = red_channel;
    contrast_stretched_img(:,:,2) = blue_channel;
    contrast_stretched_img(:,:,3) = green_channel;
    figure;
    subplot(1,2,1), imshow(uint8(image));
    colorbar;
    subplot(1,2,2), imshow(contrast_stretched_img);
    colorbar;
end
end