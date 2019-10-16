%% MyMainScript

tic;
%% Experiments on ORL Repository using the 'svd' function
%
orl_dir = "../../orl/"; % make sure that the path ends with '/'
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
%% Experiments on ORL Repository using the 'eig' function
%
% Step2: Get Eigen matrix
orl_eigen_matrix = get_eigen_matrix(orl_train_dataset, false);
% Step3: Get Recognition rates
[recognition_rates, k_values] = get_recognition_rates(orl_train_dataset,...
    orl_test_dataset, orl_eigen_matrix, "ORL", "a");
figure;
plot(k_values, recognition_rates);
title('Recognition rates (vs) k - using the eig function');
ylabel('Recognition rates');
xlabel('k');
%% Experiments on Yale Repository using complete squared error
%
yale_dir = "../../CroppedYale/"; % make sure that the path ends with '/'
% Step1: Generate datasets
[yale_train_dataset, yale_test_dataset] = get_dataset(yale_dir, "Yale");
% Step2: Get Eigen matrix
yale_eigen_matrix = get_eigen_matrix(yale_train_dataset, true);
% Step3: Get Recognition rates
[recognition_rates, k_values] = get_recognition_rates(yale_train_dataset,...
    yale_test_dataset, yale_eigen_matrix, "Yale", "a");
figure;
plot(k_values, recognition_rates);
title('Recognition rates (vs) k - using complete squared error');
ylabel('Recognition rates');
xlabel('k');
%% Experiments on Yale Repository using squared error except max three eigen coefficients
%
% Step3: Get Recognition rates
[recognition_rates, k_values] = get_recognition_rates(yale_train_dataset,...
    yale_test_dataset, yale_eigen_matrix, "Yale", "b");
figure;
plot(k_values, recognition_rates);
title('Recognition rates (vs) k - using squared error except max three');
ylabel('Recognition rates');
xlabel('k');
%%
%
toc;
