function matched_img = myHM()
%% Perform Histogram Matching (HM)
%
% SYNTAX:
%   equalized_img = myHM()
%
% OUTPUT:
%   matched_img = The image after performing Global Histogram
%   Matching on it.
%%
%
img = imread('../data/retina.png');
ref_img = imread('../data/retinaRef.png');
matched_img(:,:,1) = grayscaleHM(img(:,:,1), ref_img(:,:,1));
matched_img(:,:,2) = grayscaleHM(img(:,:,2), ref_img(:,:,2));
matched_img(:,:,3) = grayscaleHM(img(:,:,3), ref_img(:,:,3));
equalized_img = myHE(img);
close;
figure;
subplot(1,3,1), imshow(img);
title('Original');
colorbar;
subplot(1,3,2), imshow(matched_img);
title('HM');
colorbar;
subplot(1,3,3), imshow(equalized_img);
title('HE');
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
new_intensity = zeros(256, 1, 'uint8');

for array_index = 1 : 256
    diff_cdf = abs(ref_cdf - img_cdf(array_index));
    [~, indx] = min(diff_cdf);
    new_intensity(array_index) = indx;
end
matched_image = new_intensity(image+1);
end