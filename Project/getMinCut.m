function [left_cut_region, min_path_ind, path_cost] = getMinCut(error_patch)
[m, n] = size(error_patch);

% finding all possible vertical path costs
path_cost = zeros(m, n);
path_cost(1,:) = error_patch(1, :);
for row = 2 : m
    path_cost(row, :) = min([inf, path_cost(row-1, 1:n-1);...
                             path_cost(row-1, :);...
                             path_cost(row-1, 2:n), inf]...
                             + error_patch(row,:));
end

% findind the minimun path(indices) and left cut region
min_path_ind = zeros(1, m);
new_E = [inf(m, 1), path_cost, inf(m, 1)];
ind_arr = find(new_E(m,:) == min(new_E(m, :)));
min_path_ind(m) = ind_arr(1);
curr_col = min_path_ind(m);
left_cut_region = zeros(m, n);
left_cut_region(m, 1:curr_col-1) = 1;
for row = m-1:-1:1
    compare = [new_E(row, curr_col-1), new_E(row, curr_col), new_E(row, curr_col+1)];
    ind_arr = find(compare == min(compare));
    curr_col = curr_col + ind_arr(1) -2;
    min_path_ind(row) = curr_col;
    left_cut_region(row, 1:curr_col-1) = 1;
end
min_path_ind = min_path_ind-1; % doing this becuase of 'inf' at both ends
end