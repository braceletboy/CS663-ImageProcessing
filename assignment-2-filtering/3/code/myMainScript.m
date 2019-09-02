%% MyMainScript
close all;
clear all;
clc;
tic;

%% Input Images & Parameters
img1 = "../data/barbara.mat";
img2 = "../data/grass.png";
img3 = "../data/honeyCombReal.png";
window_size = 25;
patch_size = 9;
sigma_opt_arr = [25, 88, 90];
%-----------------------------------------------------------------------------------------------
%-----------------------------------------------------------------------------------------------

%% Smoothening the input image1 - barbara.mat

sigma_opt = sigma_opt_arr(1);
img_mat = load(img1);
img = double(img_mat.imageOrig);

[corrupted_img, smoothed_img] = myPatchBasedFiltering(img, sigma_opt, window_size, patch_size);

figure('Position', [80 80 1200 400]);
colormap('gray');
sgtitle('Patch Based Filtering');
subplot(1,3,1), imagesc(img);
title('Original');
colorbar;
subplot(1,3,2), imagesc(corrupted_img);
title('Corrupted');
colorbar;
subplot(1,3,3), imagesc(smoothed_img);
title('Filtered');
colorbar;

%% Displaying the mask used to make patches isotropic
gaussian_mask = fspecial('gaussian', patch_size, sigma_opt);
figure;
colormap('gray');
imagesc(gaussian_mask);
title('Mask for isotropic patches');
colorbar;

%% Optimal parameter value(sigma*) and optimal RMSD
rmsd_loss = sqrt(sum((smoothed_img-img).^2, 'all')/numel(img));

fprintf('The optimal sigma* value is %f\n', sigma_opt);
fprintf('The optimal RMSD value is %f\n', rmsd_loss);

%% RMSD values for i) 0.9*sigma and ii) 1.1*sigma

sigma = 0.9*sigma_opt;
[~, smoothed_img] = myPatchBasedFiltering(img, sigma, window_size, patch_size);
rmsd_loss = sqrt(sum((smoothed_img-img).^2, 'all')/numel(img));
fprintf('The RMSD value for 0.9*sigma is %f\n', rmsd_loss);

sigma = 1.1*sigma_opt;
[~, smoothed_img] = myPatchBasedFiltering(img, sigma, window_size, patch_size);
rmsd_loss = sqrt(sum((smoothed_img-img).^2, 'all')/numel(img));
fprintf('The RMSD value for 1.1*sigma is %f\n', rmsd_loss);
%-----------------------------------------------------------------------------------------------
%-----------------------------------------------------------------------------------------------

%% Smoothening the input image2 - grass.png
sigma_opt = sigma_opt_arr(2);
img = double(imread(img2));

[corrupted_img, smoothed_img] = myPatchBasedFiltering(img, sigma_opt, window_size, patch_size);

figure('Position', [80 80 1200 400]);
colormap('gray');
sgtitle('Patch Based Filtering');
subplot(1,3,1), imagesc(img);
title('Original');
colorbar;
subplot(1,3,2), imagesc(corrupted_img);
title('Corrupted');
colorbar;
subplot(1,3,3), imagesc(smoothed_img);
title('Filtered');
colorbar;

%% Displaying the mask used to make patches isotropic
gaussian_mask = fspecial('gaussian', patch_size, sigma_opt);
figure;
colormap('gray');
imagesc(gaussian_mask);
title('Mask for isotropic patches');
colorbar;
% 
%% Optimal parameter value(sigma*) and optimal RMSD
rmsd_loss = sqrt(sum((smoothed_img-img).^2, 'all')/numel(img));

fprintf('The optimal sigma* value is %f\n', sigma_opt);
fprintf('The optimal RMSD value is %f\n', rmsd_loss);

%% RMSD values for i) 0.9*sigma and ii) 1.1*sigma

sigma = 0.9*sigma_opt;
[~, smoothed_img] = myPatchBasedFiltering(img, sigma, window_size, patch_size);
rmsd_loss = sqrt(sum((smoothed_img-img).^2, 'all')/numel(img));
fprintf('The RMSD value for 0.9*sigma is %f\n', rmsd_loss);

sigma = 1.1*sigma_opt;
[~, smoothed_img] = myPatchBasedFiltering(img, sigma, window_size, patch_size);
rmsd_loss = sqrt(sum((smoothed_img-img).^2, 'all')/numel(img));
fprintf('The RMSD value for 1.1*sigma is %f\n', rmsd_loss);
%-----------------------------------------------------------------------------------------------
%-----------------------------------------------------------------------------------------------

%% Smoothening the input image1 - honeyCombReal.png
sigma_opt = sigma_opt_arr(3);
img = double(imread(img3));

[corrupted_img, smoothed_img] = myPatchBasedFiltering(img, sigma_opt, window_size, patch_size);

figure('Position', [80 80 1200 400]);
colormap('gray');
sgtitle('Patch Based Filtering');
subplot(1,3,1), imagesc(img);
title('Original');
colorbar;
subplot(1,3,2), imagesc(corrupted_img);
title('Corrupted');
colorbar;
subplot(1,3,3), imagesc(smoothed_img);
title('Filtered');
colorbar;

%% Displaying the mask used to make patches isotropic
gaussian_mask = fspecial('gaussian', patch_size, sigma_opt);
figure;
colormap('gray');
imagesc(gaussian_mask);
title('Mask for isotropic patches');
colorbar;

%% Optimal parameter value(sigma*) and optimal RMSD
rmsd_loss = sqrt(sum((smoothed_img-img).^2, 'all')/numel(img));

fprintf('The optimal sigma* value is %f\n', sigma_opt);
fprintf('The optimal RMSD value is %f\n', rmsd_loss);

%% RMSD values for i) 0.9*sigma and ii) 1.1*sigma

sigma = 0.9*sigma_opt;
[~, smoothed_img] = myPatchBasedFiltering(img, sigma, window_size, patch_size);
rmsd_loss = sqrt(sum((smoothed_img-img).^2, 'all')/numel(img));
fprintf('The RMSD value for 0.9*sigma is %f\n', rmsd_loss);

sigma = 1.1*sigma_opt;
[~, smoothed_img] = myPatchBasedFiltering(img, sigma, window_size, patch_size);
rmsd_loss = sqrt(sum((smoothed_img-img).^2, 'all')/numel(img));
fprintf('The RMSD value for 1.1*sigma is %f\n', rmsd_loss);
%-----------------------------------------------------------------------------------------------
%-----------------------------------------------------------------------------------------------
toc