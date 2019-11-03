function [denoised_img, rmse] = myPCADenoising1(img, sigma)
%%
%
%%
%
noisy_img = img + rand(size(img))*sigma;
patch_matrix = img2patches(noisy_img);
[eigen_matrix, ~] = eig(patch_matrix*patch_matrix');
eigen_coeff_matrix = eigen_matrix'*patch_matrix; % columns are coeff vecs

% build the vector of average squared eigen coefficients
avgsq_eigen_coeffs = sum(eigen_coeff_matrix.^2, 2)/num_patches - sigma^2;
avgsq_eigen_coeffs(:,2) = 0;
avgsq_eigen_coeffs = max(avgsq_eigen_coeffs, 2);

% denoise image
denoised_eigen_coeff_matrix = (eigen_coeff_matrix/...
                               (1 + sigma^2*1./avgsq_eigen_coeffs));
denoised_patch_matrix = eigem_matrix*denoised_eigen_coeff_matrix;
denoised_img = patches2img(denoised_patch_matrix, size(img));
rmse = sumsqr(denoised_img - img)/sumsqr(img);
end