function equalized_img = myHE(img)
%% Perform Global Histogram Equalization (GHE)
%
% SYNTAX:
%   equalized_img = myHE(img)
%
% INPUT:
%   img = The image on which GHE is to be performed
%
% OUTPUT:
%   equalized_img = The image after performing Global Histogram
%   Equalization on it.
%%
%
if length(size(img))==3
    hsv_img = rgb2hsv(img);
    intensity_channel = hsv_img(:,:,3);
    equalized_hsv_img = hsv_img;
    equalized_hsv_img(:,:,3) = grayscaleHE(intensity_channel);
    equalized_img = hsv2rgb(equalized_hsv_img);
    figure('Name', 'Original vs Equalized Images');
    subplot(1,2,1), imshow(img);
    colorbar;
    subplot(1,2,2), imshow(equalized_img);
    colorbar;
elseif length(size(img))==2
    img = double(img)/255;
    equalized_img = grayscaleHE(img);
    figure('Name', 'Original vs Equalized Images');
    subplot(1,2,1), imshow(img);
    colorbar;
    subplot(1,2,2), imshow(equalized_img);
    colorbar;
end
end

function equalized_image = grayscaleHE(image)
%% Perform Global Histogram Equalization (GHE) on the given gray scale img
%
% SYNTAX:
%   equalized_img = myHE(img)
%
% INPUT:
%   img = The gray scale image on which GHE is to be performed
%
% OUTPUT:
%   equalized_img = The equalized image after performing Global Histogram
%   Equalization on it.
%%
%
[img_cdf, edges] = get_cdf(image);
equalized_image = interp1(edges, img_cdf, image);
end