 clc;
 tic
 
 %% Inputs && parameters
texture_image = [1 2 3 5 6 7; 4 5 6 2 3 4; 7 8 10 3 4 5; 7 8 10 3 4 67; 4 5 6 2 3 4;1 2 3 5 6 7 ];
k = 3;

%% Patches(blocks) extraction
blocks = getSlices(texture_image,k);
randomblock = getRandomBlock(blocks);
%disp(randomblock);


%% Finding min cut boundary

sample_boundary_img = [1, 3, 3; 5, 1, 3; 6, 5, 8];
[left_cut_region, min_path_ind, path_cost] = getMinCut(sample_boundary_img);
disp(left_cut_region);
disp(path_cost);

toc