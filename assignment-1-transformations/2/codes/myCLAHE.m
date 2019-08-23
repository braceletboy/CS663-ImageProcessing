function enhanced_image = myCLAHE(img, window_size, threshold)
%% Perform Contrast Limited Adaptive Histogram Equalization on the image
%
% SYNTAX:
%   enhanced_image = myCLAHE(image)
%
% INPUT:
%   image = The image on which CLAHE is to be performed
%   window_size = The size of the window. It's assumed to be odd
%   threshold = The threshold for clipping histogram
%
% OUTPUT:
%   enhanced_image = The image after applying CLAHE
%
%%
%
if length(size(img))==3
    hsv_img = rgb2hsv(img);
    enhanced_hsv_img = hsv_img;
    intensity_channel = hsv_img(:,:,3);
    enhanced_intensity_channel = hsvCLAHE(intensity_channel,...
        window_size, threshold);
    enhanced_hsv_img(:,:,3) = enhanced_intensity_channel;
    enhanced_image = hsv2rgb(enhanced_hsv_img);
    figure('Name', 'Original vs CLAHE');
    subplot(1,2,1), imshow(img);
    title('Original');
    colorbar;
    subplot(1,2,2), imshow(enhanced_image);
    title('CLAHE');
    colorbar;
elseif length(size(img))==2
    enhanced_image = grayscaleCLAHE(img, window_size, threshold);
    figure('Name', 'Original vs CLAHE');
    subplot(1,2,1), imshow(img);
    title('Original');
    colorbar;
    subplot(1,2,2), imshow(enhanced_image);
    title('CLAHE');
    colorbar;
end
end

function enhanced_image = hsvCLAHE(intensity_channel, window_size, threshold)
%% Perform Contrast Limited Adaptive Histogram Equalization on intensity channel
%
% SYNTAX:
%   enhanced_image = myCLAHE(image)
%
% INPUT:
%   image = The gray scale image on which CLAHE is to be performed
%   window_size = The size of the window. It's assumed to be odd
%   threshold = The threshold for clipping histogram
%
% OUTPUT:
%   enhanced_image = The image after applying CLAHE
%
%%
%
[num_rows, num_columns] = size(intensity_channel);
enhanced_image = intensity_channel;
for row = 1:num_rows
    for column = 1:num_columns
        enhanced_image(row,column) = get_clahe_intensity_hsv(intensity_channel, row, ...
            column, window_size, threshold);
    end
end
end

function new_intensity = get_clahe_intensity_hsv(intensity_channel, row,...
    column, window_size, threshold)
%% Calculate the new pixel intensity after performing CLAHE for hsv images
%
% SYNTAX:
%   new_intensity = get_clahe_intensity(img,x,y,w)
%
% INPUTS:
%   image = The input image
%   row = The row of the pixel
%   column = The column of the pixel
%   window_size = The size of the window. It's assumed to be odd
%   threshold = The threshold for clipping histogram
%
% OUTPUT:
%   new_intensity = The new intensity of the pizel
%
%%
%
[num_rows, num_columns] = size(intensity_channel);
pixel_intensity = intensity_channel(row, column);
top_row = max([1, row - (window_size-1)/2]);
bottom_row = min([num_rows, row + (window_size-1)/2]);
left_column = max([1, column - (window_size-1)/2]);
right_column = min([num_columns, column + (window_size-1)/2]);

interested_patch = intensity_channel(top_row:bottom_row, left_column:right_column);
[cdf, edges] = get_clipped_cdf(interested_patch, threshold);
new_intensity = interp1(edges, cdf, pixel_intensity);
end

function enhanced_image = grayscaleCLAHE(img, window_size,...
    threshold)
%% Perform Contrast Limited Adaptive Histogram Equalization on gray scale image
%
% SYNTAX:
%   enhanced_image = myCLAHE(image)
%
% INPUT:
%   image = The gray scale image on which CLAHE is to be performed
%   window_size = The size of the window. It's assumed to be odd
%   threshold = The threshold for clipping histogram
%
% OUTPUT:
%   enhanced_image = The image after applying CLAHE
%
%%
%
[num_rows, num_columns] = size(img);
enhanced_image = img;
for row = 1:num_rows
    for column = 1:num_columns
        enhanced_image(row,column) = get_clahe_intensity_grayscale(...
            img, row, column, window_size, threshold);
    end
end
end

function new_intensity = get_clahe_intensity_grayscale(img, row, column,...
    window_size, threshold)
%% Calculate the new pixel intensity after performing CLAHE on gray scale
%
% SYNTAX:
%   new_intensity = get_clahe_intensity(img,x,y,w)
%
% INPUTS:
%   image = The input image
%   row = The row of the pixel
%   column = The column of the pixel
%   window_size = The size of the window. It's assumed to be odd
%   threshold = The threshold for clipping histogram
%
% OUTPUT:
%   new_intensity = The new intensity of the pizel
%
%%
%
[num_rows, num_columns] = size(img);
pixel_intensity = img(row, column);
top_row = max([1, row - (window_size-1)/2]);
bottom_row = min([num_rows, row + (window_size-1)/2]);
left_column = max([1, column - (window_size-1)/2]);
right_column = min([num_columns, column + (window_size-1)/2]);

interested_patch = img(top_row:bottom_row, left_column:right_column);
[cdf, ~] = get_clipped_cdf(interested_patch, threshold);
new_intensity = uint8(cdf(pixel_intensity+1)*255);
end

function [clipped_cdf, edges] = get_clipped_cdf(patch, threshold)
%% Return the CDF of the given patch after clipping the histogram
%
% SYNTAX:
%   clipped_cdf = get_clipped_cdf(patch)
%
% INPUT:
%   patch = The patch for which cdf is to be calculated
%   threshold = The threshold for clipping the historgram
%
% OUTPUT:
%   clipped_cdf = The cdf of the histogram clipped patch
%
%%
%
[counts, edges] = imhist(patch,256);
% Clipping Histogram
extra_hist = 0;
threshold = threshold*max(counts);
for index = 1 : 256
    if counts(index) > threshold
        extra_hist = extra_hist + counts(index) - threshold;
        counts(index) = threshold;
    end
end
counts = counts + extra_hist/256;
clipped_cdf = cumsum(counts)/sum(counts);
end