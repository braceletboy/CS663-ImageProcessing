%% MyMainScript

tic;
%% Experiments on ORL Repository using the 'svd' function
%
orl_dir = '../../../orl/'; % make sure that the path ends with '/'
yale_dir = '../../../CroppedYale/';
% Step1: Generate datasets
[orl_train_dataset, orl_test_dataset] = get_dataset(orl_dir, "ORL");
% Step2: Get Eigen matrix
orl_eigen_matrix = get_eigen_matrix(orl_train_dataset, true);
% Step3: Get Recognition rates
[recognition_rates, k_values] = get_recognition_rates(orl_train_dataset,...
    orl_test_dataset, orl_eigen_matrix, "ORL", "a");
figure;
plot(k_values, recognition_rates);
title('Recognition rates (vs) k - using the svd function');
ylabel('Recognition rates');
xlabel('k');
%%
%
[yale_train_dataset, yale_test_dataset] = get_dataset(orl_dir, "Yale");
toc;
