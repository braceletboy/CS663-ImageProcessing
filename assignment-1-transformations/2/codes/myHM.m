function matched_img = myHM(img, ref_img)
%% Perform Histogram Matching (HM)
%
% SYNTAX:
%   equalized_img = myHM(img)
%
% INPUT:
%   img = The image on which GHM is to be performed
%   ref_img = The reference image for Histogram matching
%
% OUTPUT:
%   matched_img = The image after performing Global Histogram
%   Matching on it.
%%
%
hsv_img = rgb2hsv(img);
intensity_channel = hsv_img(:,:,3);
ref_hsv_img = rgb2hsv(ref_img);
ref_intensity_channel = ref_hsv_img(:,:,3);
matched_hsv_img = hsv_img;
matched_hsv_img(:,:,3) = grayscaleHM(intensity_channel, ref_intensity_channel);
matched_img = hsv2rgb(matched_hsv_img);
equalized_img = myHE(img);
%equalized_img = zeros(size(img));
close Figure 1;
figure;
subplot(1,3,1), imshow(img);
colorbar;
subplot(1,3,2), imshow(matched_img);
colorbar;
subplot(1,3,3), imshow(equalized_img);
colorbar;
end

function matched_image = grayscaleHM(image, ref_image)
%% Perform Histogram Matching (HM) on a Gray scale image
%
% SYNTAX:
%   equalized_img = myHM(img)
%
% INPUT:
%   img = The image on which GHM is to be performed. Assumed to be
%   grayscale
%   ref_img = The reference image for Histogram matching
%
% OUTPUT:
%   matched_img = The image after performing Global Histogram
%   Matching on it.
img_cdf = get_cdf(image);
ref_cdf = get_cdf(ref_image);
new_intensity = zeros(256, 1);
for array_index = 1 : 256
    diff_cdf = abs(ref_cdf - img_cdf(array_index));
    [~, indx] = min(diff_cdf);
    new_intensity(array_index) = indx;
end
matched_image = image;
for intensity = 0:255
    matched_image(matched_image==intensity)=new_intensity(intensity+1);
end
end