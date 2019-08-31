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
figure;
sgtitle('Part (c) - Kernels');
subplot(1,5,1), imshow(filter1, [0 max(max(filter1))]);
title('Kernel - 0.2*thresh');
colorbar;
subplot(1,5,2), imshow(filter2, [0 max(max(filter2))]);
title('Kernel - 0.4*thresh');
colorbar;
subplot(1,5,3), imshow(filter3, [0 max(max(filter3))]);
title('Kernel - 0.6*thresh');
colorbar;
subplot(1,5,4), imshow(filter4, [0 max(max(filter4))]);
title('Kernel - 0.8*thresh');
colorbar;
subplot(1,5,5), imshow(filter5, [0 max(max(filter5))]);
title('Kernel - 1*thresh');
colorbar;
end