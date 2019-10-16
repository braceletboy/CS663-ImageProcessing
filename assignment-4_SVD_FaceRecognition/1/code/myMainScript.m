%% MyMainScript
%

tic;
%% Your code here
%
orl_dir = '../../../orl/'; % make sure that the path ends with '/'
yale_dir = '../../../CroppedYale/';
% Step1: Generate datasets
[orl_train_dataset, orl_test_dataset] = get_dataset(orl_dir, "ORL");
[yale_train_dataset, yale_test_dataset] = get_dataset(orl_dir, "Yale");
% Step2: Get Eigen matrix

% Step3: Get Recognition rates

%%
%
toc;
