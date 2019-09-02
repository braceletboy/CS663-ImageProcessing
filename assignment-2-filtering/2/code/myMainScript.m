




%% MyMainScript
close all;
clear all;
clc;
tic;

%% Input Images & Parameters
img1 = "../data/barbara.mat";
img2 = "../data/grass.png";
img3 = "../data/honeyCombReal.png";

sigma_spatial_arr = [0.99, 7, 2];
sigma_intensity_arr = [22, 42, 44];
window_arr = [57,3,13];
%----------------------------------------------------------------------
%----------------------------------------------------------------------

%% Smoothening the input image - barbara.mat

sigma_spatial_opt = sigma_spatial_arr(1);
sigma_intensity_opt = sigma_intensity_arr(1);
window_opt = window_arr(1);

img_mat = load(img1);
img = double(img_mat.imageOrig);

[corrupted_img, smoothed_img] = myBilateralFiltering(img, sigma_spatial_opt, ...
    sigma_intensity_opt, window_opt);

figure('Position', [80 80 1200 400]);
colormap('gray');
sgtitle('Bilateral Filtering');
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

spatial_gaussian = fspecial('gaussian', window_opt, sigma_spatial_opt);
figure;
colormap('gray');
imagesc(spatial_gaussian);
title('Mask for isotropic patches');
colorbar;

%% Optimal parameter value(sigma*) and optimal RMSD
rmsd_loss = sqrt(sum((smoothed_img-img).^2, 'all')/numel(img));

fprintf('The optimal sigma_spatial* value is %f\n', sigma_spatial_opt);
fprintf('The optimal sigma_intensity* value is %f\n', sigma_intensity_opt);
fprintf('The optimal size of window  is %f\n', window_opt);
fprintf('The optimal RMSD value is %f\n', rmsd_loss);

%% RMSD values for
%                  i) 0.9*sigma_spatial_opt and sigma_intensity_opt 
%                 ii) 1.1*sigma_spatial_opt and sigma_intensity_opt
%                iii) sigma_spatial_opt and 0.9*sigma_intensity_opt
%                 iv) sigma_spatial_opt and 1.1*sigma_intensity_opt


sigma = 0.9*sigma_spatial_opt;
[~, smoothed_img] = myBilateralFiltering(img, sigma, ...
    sigma_intensity_opt, window_opt);
rmsd_loss = sqrt(sum((smoothed_img-img).^2, 'all')/numel(img));
fprintf('The RMSD value for 0.9*sigma_spatial and sigma_intensity is %.2f\n', rmsd_loss);

sigma = 1.1*sigma_spatial_opt;
[~, smoothed_img] = myBilateralFiltering(img, sigma, ...
    sigma_intensity_opt, window_opt);
rmsd_loss = sqrt(sum((smoothed_img-img).^2, 'all')/numel(img));
fprintf('The RMSD value for 1.1*sigma_spatial and sigma_intensity is %f\n', rmsd_loss);

sigma = 0.9*sigma_intensity_opt;
[~, smoothed_img] = myBilateralFiltering(img, sigma_spatial_opt, ...
    sigma, window_opt);
rmsd_loss = sqrt(sum((smoothed_img-img).^2, 'all')/numel(img));
fprintf('The RMSD value for sigma_spatial and 0.9*sigma_intensity is %.2f\n', rmsd_loss);


sigma = 1.1*sigma_intensity_opt;
[~, smoothed_img] = myBilateralFiltering(img, sigma_spatial_opt, ...
    sigma, window_opt);
rmsd_loss = sqrt(sum((smoothed_img-img).^2, 'all')/numel(img));
fprintf('The RMSD value for sigma_spatial and 1.1*sigma_intensity is %.2f\n', rmsd_loss)
% ----------------------------------------------------------------------
% ----------------------------------------------------------------------
%% Smoothening the input image - grass.png


sigma_spatial_opt = sigma_spatial_arr(2);
sigma_intensity_opt = sigma_intensity_arr(2);
window_opt = window_arr(2);

img = double(imread(img2));

[corrupted_img, smoothed_img] = myBilateralFiltering(img, sigma_spatial_opt, ...
    sigma_intensity_opt, window_opt);

figure('Position', [80 80 1200 400]);
colormap('gray');
sgtitle('Bilateral Filtering');
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

spatial_gaussian = fspecial('gaussian', window_opt, sigma_spatial_opt);
figure;
colormap('gray');
imagesc(spatial_gaussian);
title('Mask for isotropic patches');
colorbar;

%% Optimal parameter value(sigma*) and optimal RMSD
rmsd_loss = sqrt(sum((smoothed_img-img).^2, 'all')/numel(img));

fprintf('The optimal sigma_spatial* value is %f\n', sigma_spatial_opt);
fprintf('The optimal sigma_intensity* value is %f\n', sigma_intensity_opt);
fprintf('The optimal size of window  is %f\n', window_opt);
fprintf('The optimal RMSD value is %f\n', rmsd_loss);

%% RMSD values for
%                  i) 0.9*sigma_spatial_opt and sigma_intensity_opt 
%                 ii) 1.1*sigma_spatial_opt and sigma_intensity_opt
%                iii) sigma_spatial_opt and 0.9*sigma_intensity_opt
%                 iv) sigma_spatial_opt and 1.1*sigma_intensity_opt


sigma = 0.9*sigma_spatial_opt;
[~, smoothed_img] = myBilateralFiltering(img, sigma, ...
    sigma_intensity_opt, window_opt);
rmsd_loss = sqrt(sum((smoothed_img-img).^2, 'all')/numel(img));
fprintf('The RMSD value for 0.9*sigma_spatial and sigma_intensity is %.2f\n', rmsd_loss);

sigma = 1.1*sigma_spatial_opt;
[~, smoothed_img] = myBilateralFiltering(img, sigma, ...
    sigma_intensity_opt, window_opt);
rmsd_loss = sqrt(sum((smoothed_img-img).^2, 'all')/numel(img));
fprintf('The RMSD value for 1.1*sigma_spatial and sigma_intensity is %f\n', rmsd_loss);

sigma = 0.9*sigma_intensity_opt;
[~, smoothed_img] = myBilateralFiltering(img, sigma_spatial_opt, ...
    sigma, window_opt);
rmsd_loss = sqrt(sum((smoothed_img-img).^2, 'all')/numel(img));
fprintf('The RMSD value for sigma_spatial and 0.9*sigma_intensity is %.2f\n', rmsd_loss);


sigma = 1.1*sigma_intensity_opt;
[~, smoothed_img] = myBilateralFiltering(img, sigma_spatial_opt, ...
    sigma, window_opt);
rmsd_loss = sqrt(sum((smoothed_img-img).^2, 'all')/numel(img));
fprintf('The RMSD value for sigma_spatial and 1.1*sigma_intensity is %.2f\n', rmsd_loss)

%% Smoothening the input image - honeyCombReal.png


sigma_spatial_opt = sigma_spatial_arr(3);
sigma_intensity_opt = sigma_intensity_arr(3);
window_opt = window_arr(3);

img = double(imread(img3));

[corrupted_img, smoothed_img] = myBilateralFiltering(img, sigma_spatial_opt, ...
    sigma_intensity_opt, window_opt);

figure('Position', [80 80 1200 400]);
colormap('gray');
sgtitle('Bilateral Filtering');
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

spatial_gaussian = fspecial('gaussian', window_opt, sigma_spatial_opt);
figure;
colormap('gray');
imagesc(spatial_gaussian);
title('Mask for isotropic patches');
colorbar;

%% Optimal parameter value(sigma*) and optimal RMSD
rmsd_loss = sqrt(sum((smoothed_img-img).^2, 'all')/numel(img));

fprintf('The optimal sigma_spatial* value is %f\n', sigma_spatial_opt);
fprintf('The optimal sigma_intensity* value is %f\n', sigma_intensity_opt);
fprintf('The optimal size of window  is %f\n', window_opt);
fprintf('The optimal RMSD value is %f\n', rmsd_loss);

%% RMSD values for
%                  i) 0.9*sigma_spatial_opt and sigma_intensity_opt 
%                 ii) 1.1*sigma_spatial_opt and sigma_intensity_opt
%                iii) sigma_spatial_opt and 0.9*sigma_intensity_opt
%                 iv) sigma_spatial_opt and 1.1*sigma_intensity_opt

sigma = 0.9*sigma_spatial_opt;
[~, smoothed_img] = myBilateralFiltering(img, sigma, ...
    sigma_intensity_opt, window_opt);
rmsd_loss = sqrt(sum((smoothed_img-img).^2, 'all')/numel(img));
fprintf('The RMSD value for 0.9*sigma_spatial and sigma_intensity is %.2f\n', rmsd_loss);

sigma = 1.1*sigma_spatial_opt;
[~, smoothed_img] = myBilateralFiltering(img, sigma, ...
    sigma_intensity_opt, window_opt);
rmsd_loss = sqrt(sum((smoothed_img-img).^2, 'all')/numel(img));
fprintf('The RMSD value for 1.1*sigma_spatial and sigma_intensity is %f\n', rmsd_loss);

sigma = 0.9*sigma_intensity_opt;
[~, smoothed_img] = myBilateralFiltering(img, sigma_spatial_opt, ...
    sigma, window_opt);
rmsd_loss = sqrt(sum((smoothed_img-img).^2, 'all')/numel(img));
fprintf('The RMSD value for sigma_spatial and 0.9*sigma_intensity is %.2f\n', rmsd_loss);


sigma = 1.1*sigma_intensity_opt;
[~, smoothed_img] = myBilateralFiltering(img, sigma_spatial_opt, ...
    sigma, window_opt);
rmsd_loss = sqrt(sum((smoothed_img-img).^2, 'all')/numel(img));
fprintf('The RMSD value for sigma_spatial and 1.1*sigma_intensity is %.2f\n', rmsd_loss)

 toc