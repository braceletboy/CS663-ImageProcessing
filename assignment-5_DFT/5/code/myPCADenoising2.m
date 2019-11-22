function [denoised_img, noisy_img, rmse] = myPCADenoising2(img, sigma, ...
                                                       num_similar_patches)
%%  Perform PCA Denoising using similar patches
%
% SYNTAX:
%   denoised_img = myPCADenoising2(img, sigma, num_similar_patches);
%
% INPUTS:
%   img = The input image for noising and denoising.
%   sigma = The sigma for the noise.
%   num_similar_patches = The number of similar patches to consider for
%   each patch
%
% OUTPUT:
%   denoised_img = The denoised image.
%
%%
%
noisy_img = img + randn(size(img))*sigma;
[num_rows, num_columns] = size(img);
patch_matrix = img2patches(noisy_img);
denoised_patch_matrix = zeros(size(patch_matrix));
num_patches = (num_rows-6)*(num_columns-6);
row = 0;
for idx = 1:num_patches
    column = mod(idx,num_columns-6);
    if column==0
        column = num_columns-6;
    elseif column==1
        row = row + 1;
    end
    similar_patches = get_similar_patches(img, row, column, ...
                                          num_similar_patches);
    [eigen_matrix, ~] = eig(similar_patches*similar_patches');
    eigen_coeff_matrix = eigen_matrix'*similar_patches;
    
    % build the vector of average squared eigen coefficients
    avgsq_eigen_coeffs = (sum(eigen_coeff_matrix.^2, 2)/...
                          num_similar_patches - sigma^2);
    avgsq_eigen_coeffs(:,2) = 0;
    avgsq_eigen_coeffs = max(avgsq_eigen_coeffs, [], 2);
    
    % denoise image
    denoised_eigen_coeff_matrix = (eigen_coeff_matrix.*(1./...
                                   (1 + sigma^2*1./avgsq_eigen_coeffs)));
    denoised_patch = eigen_matrix*denoised_eigen_coeff_matrix(:,1);
    denoised_patch_matrix(:,idx) = denoised_patch;
end
denoised_img = patches2img(denoised_patch_matrix, size(img));
rmse = sumsqr(denoised_img - img)/sumsqr(img);
end