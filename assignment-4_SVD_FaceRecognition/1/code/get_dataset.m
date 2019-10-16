function [train_dataset, test_dataset] = get_dataset(path, dataset_name)
%% Generate train and test datasets.
%
% SYNTAX:
%   [train_dataset, test_dataset] = getOrlData(path, image_shape)
%
% INPUTS:
%   path: The path to the ORL dataset directory.
%   dataset_name: "ORL" or "Yale".
%
% OUTPUTS:
%   train_dataset = The train dataset generated.
%   test_dataset = The test dataset generated.
%
%%
%
    if strcmp(dataset_name, "ORL")
        image_shape = [112,92];
        train_dataset = zeros(prod(image_shape),32*6);
        test_dataset = zeros(prod(image_shape), 32*4);
        for idx = 1:32
            folder_path = sprintf('%ss%i/*.pgm', path, idx);
            files = dir(folder_path);
            for jdx = 1:length(files)
                image_path = sprintf('%ss%i/%s', path, idx, ...
                                     files(jdx).name);
                img = imread(image_path);
                img = double(img)/255;
                img_features = img(:);
                if (jdx<=6)
                    train_dataset(:,(idx-1)*6+jdx) = img_features;
                else
                    test_dataset(:,(idx-1)*4+(jdx-6)) = img_features;
                end
            end
        end
    elseif strcmp(dataset_name, "Yale")
        image_shape = [192,168];
        train_dataset = zeros(prod(image_shape),38*40);
        test_dataset = zeros(prod(image_shape), 38*24);
        for idx = 1:39
            if (idx==14)
                continue
            end
            folder_path = sprintf('%syaleB%02d/*.pgm', path, idx);
            files = dir(folder_path);
            for jdx = 1:length(files)
                image_path = sprintf('%syaleB%02d/%s', path, idx, ...
                    files(jdx).name);
                img = imread(image_path);
                img_features = img(:);
                if (jdx<=40)
                    train_dataset(:,(idx-1)*40+jdx) = img_features;
                else
                    test_dataset(:,(idx-1)*24+(jdx-40)) = img_features;
                end
            end
        end
    end
end