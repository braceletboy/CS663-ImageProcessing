%% MyMainScript
clear all;
close all;
clc;

tic;
%% Part-(a) [I] - Denoising without using windows for barbara256.png
sigma = 20;
img = double(imread('../data/barbara256.png'));
[denoised_img, noisy_img, rmse] = myPCADenoising1(img, sigma);
figure('Name','PCA Denoisation of Barbara', 'Position', [100 100 1200 1200]);
subplot(1,3,1);
imshow(img, [min(min(img)) max(max(img))]);
title('Original Image');
colorbar;
subplot(1,3,2);
imshow(noisy_img, [min(min(noisy_img)) max(max(noisy_img))]);
title('Noisy Image');
colorbar;
subplot(1,3,3);
imshow(denoised_img, [min(min(denoised_img)) max(max(denoised_img))]);
title('Denoised Image');
colorbar;
fprintf('The RMSE for barbara256.png in Part-(a) is: %.2f\n',rmse);
%% Part-(a) [II] - Denoising without using windows for stream.png
sigma = 20;
img = double(imread('../data/stream.png'));
[denoised_img, noisy_img, rmse] = myPCADenoising1(img, sigma);
figure('Name','PCA Denoisation of Stream', 'Position', [100 100 1200 1200]);
subplot(1,3,1);
imshow(img, [min(min(img)) max(max(img))]);
title('Original Image');
colorbar;
subplot(1,3,2);
imshow(noisy_img, [min(min(noisy_img)) max(max(noisy_img))]);
title('Noisy Image');
colorbar;
subplot(1,3,3);
imshow(denoised_img, [min(min(denoised_img)) max(max(denoised_img))]);
title('Denoised Image (PCA Denoisation without windows)');
colorbar;
fprintf('The RMSE for stream.png in Part-(a) is: %.2f\n',rmse);
%% Part-(b) [I] - Denoising without using windows for barbara256.png
sigma = 20;
num_similar_patches = 200;
img = double(imread('../data/barbara256.png'));
[denoised_img, noisy_img, rmse] = myPCADenoising2(img, sigma, ...
                                                  num_similar_patches);
figure('Name','Windowed PCA Denoisation of Barbara', 'Position', ...
       [100 100 1200 1200]);
subplot(1,3,1);
imshow(img, [min(min(img)) max(max(img))]);
title('Original Image');
colorbar;
subplot(1,3,2);
imshow(noisy_img, [min(min(noisy_img)) max(max(noisy_img))]);
title('Noisy Image');
colorbar;
subplot(1,3,3);
imshow(denoised_img, [min(min(denoised_img)) max(max(denoised_img))]);
title('Denoised Image (Windowed PCA Denoisation)');
colorbar;
fprintf('The RMSE for barbara256.png in Part-(b) is: %.2f\n',rmse);
%% Part-(b) [II] - Denoising without using windows for stream.png
sigma = 20;
num_similar_patches = 200;
img = double(imread('../data/stream.png'));
[denoised_img, noisy_img, rmse] = myPCADenoising2(img, sigma, ...
                                                  num_similar_patches);
figure('Name','Windowed PCA Denoisation of Stream', 'Position', ...
       [100 100 1200 1200]);
subplot(1,3,1);
imshow(img, [min(min(img)) max(max(img))]);
title('Original Image');
colorbar;
subplot(1,3,2);
imshow(noisy_img, [min(min(noisy_img)) max(max(noisy_img))]);
title('Noisy Image');
colorbar;
subplot(1,3,3);
imshow(denoised_img, [min(min(denoised_img)) max(max(denoised_img))]);
title('Denoised Image (Windowed PCA Denoisation)');
colorbar;
fprintf('The RMSE for stream.png in Part-(b) is: %.2f\n',rmse);
%% Part-(c) - Bilateral Filtering for barbara256.png
%   Compared to the Bilateral filtering approach we find that PCA Denoising
%   with Windowing is far superior. This is shown by the quality of the
%   denoised images obtained for both the algorithms.
sigma = 20;
spatial_sigma = 1;
intensity_sigma = 22;
window_size = 57;
img = double(imread('../data/barbara256.png'));
[denoised_img, noisy_img, rmse] = myBilateralFiltering(img, sigma, ...
                                                  spatial_sigma, ...
                                                  intensity_sigma, ...
                                                  window_size);
figure('Name','Bilateral Filtering of Barbara', 'Position', ...
       [100 100 1200 1200]);
subplot(1,3,1);
imshow(img, [min(min(img)) max(max(img))]);
title('Original Image');
colorbar;
subplot(1,3,2);
imshow(noisy_img, [min(min(noisy_img)) max(max(noisy_img))]);
title('Noisy Image');
colorbar;
subplot(1,3,3);
imshow(denoised_img, [min(min(denoised_img)) max(max(denoised_img))]);
title('Denoised Image (Bilateral Filtering)');
colorbar;
fprintf('The RMSE for barbara256.png in Part-(c) is: %.2f\n',rmse);
%% Part-(d) [I] - Denoising without using windows for barbara256.png with Poisson Noise
sigma = 1/4;
num_similar_patches = 200;
img = double(imread('../data/barbara256.png'));
sq_img = sqrt(img + 3/8);
[denoised_sq_img, noisy_img, rmse] = myPCADenoising2(sq_img, sigma, ...
                                                  num_similar_patches);
denoised_img = denoised_sq_img.^2 - 3/8;
figure('Name','Windowed PCA Denoisation of Barbara(Poisson Distributed)',...
       'Position', [100 100 1200 1200]);
subplot(1,3,1);
imshow(img, [min(min(img)) max(max(img))]);
title('Original Image');
colorbar;
subplot(1,3,2);
imshow(noisy_img, [min(min(noisy_img)) max(max(noisy_img))]);
title('Poisson Noisy Image');
colorbar;
subplot(1,3,3);
imshow(denoised_img, [min(min(denoised_img)) max(max(denoised_img))]);
title('Denoised Image (Windowed PCA Denoisation)');
colorbar;
fprintf('The RMSE for barbara256.png in Part-(d) is: %.2f\n',rmse);
%% Part-(d) [II] - Denoising without using windows for barbara256.png with Poisson Noise and Less Brightness
sigma = 1/4;
num_similar_patches = 200;
img = double(imread('../data/barbara256.png'))/20;
sq_img = sqrt(img + 3/8);
[denoised_sq_img, noisy_img, rmse] = myPCADenoising2(sq_img, sigma, ...
                                                  num_similar_patches);
denoised_img = denoised_sq_img.^2 - 3/8;
figure('Name','Windowed PCA Denoisation of Barbara(Poisson Distributed and Less Brightness)',...
       'Position', [100 100 1200 1200]);
subplot(1,3,1);
imshow(img, [min(min(img)) max(max(img))]);
title('Less Bright Original Image');
colorbar;
subplot(1,3,2);
imshow(noisy_img, [min(min(noisy_img)) max(max(noisy_img))]);
title('Less Bright Poisson Noisy Image');
colorbar;
subplot(1,3,3);
imshow(denoised_img, [min(min(denoised_img)) max(max(denoised_img))]);
title('Denoised Image (Windowed PCA Denoisation)');
colorbar;
fprintf('The RMSE for less bringht barbara256.png in Part-(d) is: %.2f\n',rmse);
%% Part-(e) Clamping Values
%   The weiner update rule in PCA based Denoising is a statistical update
%   rule. But, on the other hand any such clamping introduced is an
%   empirical one. This leads to the PCA-based filtering technique lose
%   it's theoretical footing. I think, such a clamping of values not a
%   correct approach.
%%
toc;
