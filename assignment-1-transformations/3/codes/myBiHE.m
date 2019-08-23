function myBiHE()
%% Perform Bi-Histogram Equalization described in the question on statue.png
%
% SYNTAX:
%   myBiHE();
%
% Refer [https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=580378]
%%
threshold = 15;
statue_img = imread('../data/statue.png');
mask = (statue_img>threshold);
img = statue_img.*uint8(mask);
[counts, ~] = imhist(img,256);
cdf = cumsum(counts)/sum(counts);
[~, split_index] = min(abs(cdf-0.5));
cdf1 = uint8(cdf(1:split_index)*(split_index-1));
cdf2 = uint8((cdf(split_index+1:end) - 0.5)*(length(counts)-split_index-1));
cdf_biHE = [cdf1; cdf2];
biHE_equalized_img = uint8(cdf_biHE(img+1));
HE_equalized_img = myHE(img);
figure('Name', 'Original vs HE vs Bi-HE');
subplot(1,3,1), imshow(img);
title('Original');
colorbar;
subplot(1,3,2), imshow(HE_equalized_img);
title('HE');
colorbar;
subplot(1,3,3), imshow(biHE_equalized_img);
title('Bi-HE');
colorbar;
end

function equalized_image = myHE(img)
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
[counts, ~] = imhist(img);
img_cdf = cumsum(counts)/sum(counts);
equalized_image = uint8(img_cdf(img+1)*255);
end