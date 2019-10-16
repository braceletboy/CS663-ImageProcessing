%% MyMainScript
clc;
close all;
tic;

%% Approach
% Here we propose a solution based on thresholding the squared difference
% between eigen coefficents.
% We can solve the problem in 2 ways 

% Method i) We can define(tune) the threshold such that squared difference of all
% the internal test images(images of persons who are part of the training set) will be less
% than or equal to threshold and that of the external test images(images of persons who are
% not part of the training set) will be greater than threshold.
% we can find this threshold by calculating the maximum of minimum squared
% difference of all the internal test images.

% Method ii) We can utilize the signficance of the false positives and false
% negatives. false negatives occur with internal test images(because all
% the internal test images ideally would result in a positive match),
% whereas false positives occur with external test images(because all
% the external test images ideally should result in a negative match).
% hence if we can set the threshold such that the false positives are as
% low as possible and false negatives are also considerably low(i.e, if the false negatives
% are high in number implies the recognition rate is very poor)

% Below we have implemented the (ii) second approach i.e, exploiting the
% false positives/negatives.
% we tuned the threshold and set it to 44 where we are getting 4 false
% positives(compared to maximum value 80 ==> ~5%) and 41 false negatives(compared
% to maximum value 128 ==> recognition rate ~ 70%) we can vary this further
% as per our requirement.
%% Input data & image database location paths
orl_dir = '../../orl/'; % make sure that the path ends with '/'
threshold = 44;
k = 24; % top k eigen values
%% 
% Step1: Generate datasets
[orl_train_dataset, orl_test_dataset] = get_dataset(orl_dir, "ORL");
internal_test_images = orl_test_dataset;
external_test_images = get_external_images(orl_dir);
x_bar = mean(orl_train_dataset, 2);

% Step2: Get Eigen matrix
orl_eigen_matrix = get_eigen_matrix(orl_train_dataset, true);

V_hat = orl_eigen_matrix(:, 1:k);
alphas_train = V_hat'*(orl_train_dataset-x_bar);

alphas_internal_test = V_hat'*(internal_test_images - x_bar);
alphas_external_test = V_hat'*(external_test_images - x_bar);
%% fasle positives/false negatives

% calculating false negatives
false_negs = 0; % max false negatives can be 32*4 = 128
for i = 1 : size(internal_test_images, 2)
    dist = sum((alphas_train - alphas_internal_test(:,i)).^2);  
    if(min(dist) > threshold)
        false_negs = false_negs + 1;
    end
end

% calculating false positives
false_pos = 0; % max value can be 8*10 = 80
for i = 1 : size(external_test_images, 2)
    dist = sum((alphas_train - alphas_external_test(:,i)).^2);  
    if(min(dist) <= threshold)
        false_pos = false_pos + 1;
    end
end

fprintf('Number of false positives are %d\n', false_pos);
fprintf('Number of false negatives are %d\n', false_negs);
