function [recog_rates, k_vals] = get_recognition_rates(train_dataset, ...
                                             test_dataset,eigen_matrix, ...
                                             dataset_name, distance_type)
%% Calculate the recognition rates.
%
% SYNTAX:
%   recog_rates = get_recognition_rate(train_dataset, test_dataset, 
%                                      dataset_name, error_type, svd_bool)
%
% INPUTS:
%   train_dataset = The dataset on which recognition system was trained.
%   test_dataset = The dataset on which the recognition system is tested.
%   eigen_matrix = The matrix of eigen vectors of the training dataset.
%   dataset_name = The name of the dataset being used
%   distance_type = "a" (squared difference between all the eigen
%    coefficients) or "b" (same squared difference except the three largest
%    eigen coefficients)
%
% OUPUTS:
%   recog_rates = The recognition rates
%   k_vals = The set of k-values corresponding to the recognition rates
%
%%
%
    dataset_mean = mean(train_dataset,2);
    train_dataset = train_dataset - dataset_mean;
    test_dataset = test_dataset - dataset_mean;
    
    if strcmp(dataset_name, "ORL")
        k_vals = [1,2,3,5,10,15,20,30,50,75,100,150,170];
    elseif strcmp(dataset_name, "Yale")
        k_vals = [1,2,3,5,10,15,20,30,50,60,65,75,100,200,300,500,1000];
    end
    recog_rates = zeros(1, length(k_vals));
%     progressbar = waitbar(0, 'Initializing...', 'Name', ...
%                           sprintf('%s - Progressbar for the k-values', ...
%                                   dataset_name));
    for idx = 1:length(k_vals)
        k = k_vals(idx);
        match_count = 0;
        if (strcmp(distance_type,"b"))
            k_eigen_matrix = eigen_matrix(:,4:k);
        else
            k_eigen_matrix = eigen_matrix(:,1:k);
        end
        
        alpha_test = k_eigen_matrix'*test_dataset;
        num_test_samples = size(alpha_test,2);
        alpha_train = k_eigen_matrix'*train_dataset;
        for jdx = 1:num_test_samples
%             dist = get_distance(alpha_train, alpha_test(:,jdx), ...
%                                 distance_type);
            dist = sum((alpha_train - alpha_test(:,jdx)).^2);
            [~,match_idx] = min(dist);
            if strcmp(dataset_name, "ORL")
                if(floor((match_idx-1)/6)==floor((jdx-1)/4))
                    match_count = match_count + 1;
                end
            elseif strcmp(dataset_name, "Yale")
                if(floor((match_idx-1)/40)==floor((jdx-1)/24))
                    match_count = match_count + 1;
                end
            end
        end
        recog_rates(idx) = (100*match_count)/num_test_samples;
%         percent_complete = 100*idx/length(k_vals);
%         waitbar(percent_complete, progressbar,...
%                 sprintf('%.2f%% Completed',percent_complete));
    end
%     close(progressbar);
end

% function dist = get_distance(alpha_train, alpha_test_sample, distance_type)
%     dist = sum((alpha_train - alpha_test_sample).^2);
%     if strcmp(distance_type,"a")
%         dist = sum((alpha_train - alpha_test_sample).^2);
%     elseif strcmp(distance_type,"b")
%         k = length(alpha_test_sample);
%         if k>=3
%             [~,indices] = mink(alpha_test_sample, k-3);
%             dist = rssq(alpha_train(indices,:) - ...
%                         alpha_test_sample(indices));
%         else
%             dist = zeros(1,size(alpha_train,2));
%         end
%     end
% end