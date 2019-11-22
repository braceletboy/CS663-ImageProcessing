function filtered_img = gaussian_filter(img, sigma)
%% Apply low pass gaussian filter to the given image
%
% SYNTAX:
%   filtered_img = gaussian_filter(img, sigma)
%
% INPUTS:
%   img = The input image
%   sigma = The sigma for the gaussian
%
% OUTPUT:
%   filtered_img = The filtered image
%
%%
%
shifted_fft_img = fftshift(fft2(img));
gaussian_filter = fspecial('gaussian', size(img), sigma);
filtered_fft_img = shifted_fft_img.*gaussian_filter;
filtered_img = abs(ifft2(ifftshift(filtered_fft_img)));
end