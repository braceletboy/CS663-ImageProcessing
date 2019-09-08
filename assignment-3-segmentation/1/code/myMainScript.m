%% MyMainScript

tic;
%% Your code here
img_mat = load('../data/boat.mat');
img = double(img_mat.imageOrig);
img = img/max(max(img));
sigma1 = 0.25;
sigma2 = 10;
corn_k = 0.15;
threshlod = 0.05;

%% 1st Gaussian Smoothing -- noise removal
img=imgaussfilt(img,sigma1);

%% Imgae derivatives along X and Y using Sobel operator
[Ix, Iy] = imgradientxy(img, 'sobel');
figure('name','ImageDerivatives','Position', [100 100 1200 400]);
subplot(1,2,1),imshow(Ix);
colormap('gray');
title('Y - Derivative of img');
subplot(1,2,2),imshow(Iy);
colormap('gray');
title('Y - Derivative of img');
%% Eigen values of Structure Tensor
Ix2 = Ix.^2;
Iy2 = Iy.^2;
Ixy = Ix.*Iy;
trace = Ix2 + Iy2;
det = Ix2.*Iy2 - Ixy.^2;

eig_min=(trace/2)-((trace/2).^2 - det).^(1/2);
eig_max=(trace/2) +((trace/2).^2 - det).^(1/2);

figure('name','Eigen Value Images','Position', [100 100 1200 400]);
subplot(1,2,1),imshow(eig_min/max(max(eig_min)));
colormap('gray');
title('Eigen minimum');
subplot(1,2,2),imshow(eig_max/max(max(eig_max)));
colormap('gray');
title('Eigen maximum');

%%  Harris corner-ness measure
corners = myHarrisCornerDetector(eig_min, eig_max, corn_k, threshlod);
figure('name','Corner-ness','Position', [100 100 1200 400]);
imshow(corners);
colormap('gray');
title('Eigen minimum');
toc;
