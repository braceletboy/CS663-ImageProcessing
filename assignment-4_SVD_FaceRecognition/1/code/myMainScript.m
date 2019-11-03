%% MyMainScript
clc;
close all;
tic;

%% Inputs and image database paths
orl_dir = "../../orl/"; % make sure that the path ends with '/'
yale_dir = "../../CroppedYale/"; % make sure that the path ends with '/'

%% Experiments on ORL Repository 
% Using the 'svd' function
%
% Step1: Generate datasets
[orl_train_dataset, orl_test_dataset] = get_dataset(orl_dir, "ORL");
% Step2: Get Eigen matrix using svd (argument 'true' is passed)
orl_eigen_matrix = get_eigen_matrix(orl_train_dataset, true);
% Step3: Get Recognition rates
[recognition_rates, k_values] = get_recognition_rates(orl_train_dataset,...
    orl_test_dataset, orl_eigen_matrix, "ORL", "a");
figure;
plot(k_values, recognition_rates);
title('Recognition rates for ORL using the svd function');
ylabel('Recognition rates');
xlabel('k');
%% Experiments on ORL Repository 
% Using the 'eig' function
%
% Step2: Get Eigen matrix using eig (argument 'false' is passed)
orl_eigen_matrix = get_eigen_matrix(orl_train_dataset, false);
% Step3: Get Recognition rates
[recognition_rates, k_values] = get_recognition_rates(orl_train_dataset,...
    orl_test_dataset, orl_eigen_matrix, "ORL", "a");
figure;
plot(k_values, recognition_rates);
title('Recognition rates for ORL using the eig function');
ylabel('Recognition rates');
xlabel('k');
%% Experiments on Yale Repository 
% Using complete squared error
%
% Step1: Generate datasets
[yale_train_dataset, yale_test_dataset] = get_dataset(yale_dir, "Yale");
% Step2: Get Eigen matrix
yale_eigen_matrix = get_eigen_matrix(yale_train_dataset, true);
% Step3: Get Recognition rates
[recognition_rates, k_values] = get_recognition_rates(yale_train_dataset,...
    yale_test_dataset, yale_eigen_matrix, "Yale", "a");
figure;
plot(k_values, recognition_rates);
title('Recognition rates of Yale before removing top three eigs');
ylabel('Recognition rates');
xlabel('k');
%% Experiments on Yale Repository using squared error except max three eigen coefficients
%
% Step3: Get Recognition rates
[recognition_rates, k_values] = get_recognition_rates(yale_train_dataset,...
    yale_test_dataset, yale_eigen_matrix, "Yale", "b");
figure;
plot(k_values, recognition_rates);
title('Recognition rates of Yale after removing top three eigs');
ylabel('Recognition rates');
xlabel('k');
%%
%
toc;
