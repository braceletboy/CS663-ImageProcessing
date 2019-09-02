function mask = generate_bokeh_mask(img)
%% Generate Bokeh Mask for the given image using segmentation
%   This method first calculates an edge image and then uses it as the 
%   preliminary mask for the Chan-Vese method. This method gives us the
%   final mask.
%
% NOTE:
%   The 'Roberts' filter seems to work best for our purpose, while finding
%   the edges.
%
% SYNTAX:
%   mask = generate_bokeh_mask(img);
%
% INPUT:
%   img = The image for which bokeh mask is to be generated
%   patch_size = The patch size to be used for the preliminary mask
%   generation
%
% OUTPUT:
%   mask = The generated mask
%
% Reference1: [https://in.mathworks.com/help/images/ref/activecontour.html]
% Reference2: [https://in.mathworks.com/help/images/ref/edge.html]
%%
%
gray_img = rgb2gray(img);
preliminary_mask = edge(gray_img, 'roberts');
mask = activecontour(img, preliminary_mask, 'Chan-Vese', ...
    'ContractionBias', -0.3);
inverted_mask = (1 - mask);
foreground_img = bsxfun(@times, img, cast(mask, 'like', img));
background_img = bsxfun(@times, img, cast(inverted_mask, 'like', img));
figure('Position', [80 80 1300 300]);
sgtitle('Part (c) - (i) Mask and Masked images');
subplot(1,3,1), imagesc(mask), colormap('gray');
title('Mask');
subplot(1,3,2), imagesc(foreground_img);
title('Foreground');
subplot(1,3,3), imagesc(background_img);
title('Background');
end