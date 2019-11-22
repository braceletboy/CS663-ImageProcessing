%% MyMainScript
clear all;
close all;
clc;

tic;
%% Your code here
img = load('../data/image_low_frequency_noise.mat').Z;
figure('Position', [100 100 1200 1200]);
subplot(2,2,1);
imagesc(img);
title('Original Image');
colorbar;

ft_img = fft2(img);
shifted_ft_img = fftshift(ft_img);
ft_img_abs = abs(shifted_ft_img);

% log absolute value of fft
ft_img_logabs = log(ft_img_abs);
subplot(2,2,2);
imagesc(ft_img_logabs);
title('FFT - Log Absolute');
colorbar;

% Notching the noise frequencies
shifted_ft_img(114:124, 119:129) = 0;  % masking the noise
shifted_ft_img(134:144, 129:139) = 0;  % masking the noise
subplot(2,2,3);
imagesc(log(abs(shifted_ft_img)));
title('Notched FFT - Log Absolute');
colorbar;

% denoised image
denoised_img = ifft2(ifftshift(shifted_ft_img));
subplot(2,2,4);
imagesc(denoised_img);
title('Denoised - Image');
colorbar;
%%
toc;
