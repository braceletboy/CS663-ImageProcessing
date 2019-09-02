function display_kernels(thresh_dist)
%% Display the kernels used for the various distances
%   The various distances are 0.2*thresh_dist, 0.4*thresh_dist,
%   0.6*thresh_dist, 0.8*thresh_dist, 1*thresh_dist
%
% SYNTAX:
%   display_kernels(thresh_dist);
%
% INPUT:
%   thresh_dist = The thresholding distance
%
%%
%
thresh_dist = double(thresh_dist);
filter1 = fspecial('disk', 0.2*thresh_dist);
filter2 = fspecial('disk', 0.4*thresh_dist);
filter3 = fspecial('disk', 0.6*thresh_dist);
filter4 = fspecial('disk', 0.8*thresh_dist);
filter5 = fspecial('disk', 1*thresh_dist);
figure('Position', [80 80 1400 200]);
colormap('gray');
sgtitle('Part (c) - (iii) Kernels');
subplot(1,5,1), imagesc(filter1);
title('Kernel - 0.2*thresh');
colorbar;
subplot(1,5,2), imagesc(filter2);
title('Kernel - 0.4*thresh');
colorbar;
subplot(1,5,3), imagesc(filter3);
title('Kernel - 0.6*thresh');
colorbar;
subplot(1,5,4), imagesc(filter4);
title('Kernel - 0.8*thresh');
colorbar;
subplot(1,5,5), imagesc(filter5);
title('Kernel - 1*thresh');
colorbar;
end