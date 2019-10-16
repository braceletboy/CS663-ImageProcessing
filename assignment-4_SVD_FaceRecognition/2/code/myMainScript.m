%% MyMainScript -- Reconstruction of a face image from the ORL database using svd function

tic;
%% Input data
orl_dir = '../../../orl/'; % make sure that the path ends with '/'
image_path = ' ';
img = imread(image_path);
img = double(img)/255;
img = img(:);

k_vals = [2, 10, 20, 50, 75, 100, 125, 150, 175];

%% Extracting K eigen values
% Step1: Generate datasets
[orl_train_dataset, orl_test_dataset] = get_dataset(orl_dir, "ORL");
% Step2: Get Eigen matrix
orl_eigen_matrix = get_eigen_matrix(orl_train_dataset, true);



%% Displaying the eigen faces
figure;
for i = 1:25
    eig_face = reshape(V(:, i), 192, 168);
    subplot(5,5,i);
    imagesc(eig_face);
    colormap('gray');
    title(['Eigenface #' num2str(i)]);
end
toc;
