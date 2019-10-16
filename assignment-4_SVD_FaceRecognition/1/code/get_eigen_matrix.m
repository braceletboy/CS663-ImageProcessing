function eigen_matrix = get_eigen_matrix(train_dataset, svd_bool)
%% Return the eigen matrix of the given train dataset.
%
% SYNTAX:
%   eigen_matrix = get_eigen_matrix(train_dataset, svd_bool)
%
% INPUTS:
%   train_dataset = The train dataset.
%   svd_bool = Whether to use 'svd'(true) or 'eig'(false) for eigen matrix 
%              calculation.
%
% OUTPUTS:
%   eigen_matrix = The matrix of eigen values
%
%%
%
    dataset_mean = mean(train_dataset,2);
    train_dataset = train_dataset - dataset_mean;
    if (svd_bool)
        [eigen_matrix,~,~] = svd(train_dataset, 'econ');
    else
        L_matrix = (train_dataset'*train_dataset);
        [eigen_vectors, eigen_values] = eig(L_matrix, 'vector');
        eigen_matrix = normalize(train_dataset*eigen_vectors);
        [~, sorted_indices] = sort(eigen_values,'descend');
        eigen_matrix(:,:) = eigen_matrix(:,sorted_indices);
    end
end