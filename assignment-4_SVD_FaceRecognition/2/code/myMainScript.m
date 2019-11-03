%% MyMainScript -- Reconstruction of a face image from the ORL database using svd function
clc;
close all;
tic;
%% Input data
orl_dir = '../../orl/'; % make sure that the path ends with '/'
yale_dir = '../../CroppedYale/';
k_vals = [2, 10, 20, 50, 75, 100, 125, 150, 175];

%% Reconstruction by extracting K eigen values
% Step1: Generate datasets
[orl_train_dataset, orl_test_dataset] = get_dataset(orl_dir, "ORL");
% Step2: Get Eigen matrix
orl_eigen_matrix = get_eigen_matrix(orl_train_dataset, true);

sample_img = orl_train_dataset(:, 8);
x_bar = mean(orl_train_dataset, 2);
sample_img_mean = sample_img - x_bar;

for k = 1 : length(k_vals)
   V_hat = orl_eigen_matrix(:, 1:k_vals(k));
   alphas_sample = V_hat'*sample_img_mean;
   
   % reconstruction
   sample_new = x_bar + V_hat*alphas_sample;
   new_img = reshape(sample_new, 112, 92);
   
   % Plotting
   subplot(3, 3, k);
   imshow(new_img);
   title(['Reconstructed at k = ' num2str(k_vals(k))]);
   
end


%% Displaying the 25 eigen faces
figure('name','Eigen Faces','Position', [100 100 900 600]);
for i = 1:25
    eig_face = reshape(orl_eigen_matrix(:, i), 112, 92);
    subplot(5,5,i);
    imagesc(eig_face);
    colormap('gray');
    title(['Eigenface #' num2str(i)]);
end
toc;
