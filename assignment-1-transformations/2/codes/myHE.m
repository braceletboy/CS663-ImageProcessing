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
    equalized_hsv_img(:,:,3) = hsvHE(intensity_channel);
    equalized_img = hsv2rgb(equalized_hsv_img);
    figure('Name', 'Original vs Equalized Images');
    subplot(1,2,1), imshow(img);
    title('Original');
    colorbar;
    subplot(1,2,2), imshow(equalized_img);
    title('HE');
    colorbar;
elseif length(size(img))==2
    equalized_img = grayscaleHE(img);
    figure('Name', 'Original vs Equalized Images');
    subplot(1,2,1), imshow(img);
    title('Original');
    colorbar;
    subplot(1,2,2), imshow(equalized_img);
    title('HE');
    colorbar;
end
end

function equalized_image = hsvHE(intensity_channel)
%% Perform Global Histogram Equalization (GHE) on the given intensity channel
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
%
%%
%
[img_cdf, edges] = get_cdf(intensity_channel);
equalized_image = interp1(edges, img_cdf, intensity_channel);
end

function equalized_image = grayscaleHE(img)
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
%
%%
%
[img_cdf, ~] = get_cdf(img);
equalized_image = uint8(img_cdf(img+1)*255);
end