function [cdf, edges] = get_cdf(img)
%% Return the CDF of the intensities in the gray-scaled image
%
% SYNTAX:
%   cdf = getCDF(img);
%
% INPUT:
%   img = The input image
%
% OUTPUT:
%   cdf = The CDF of the intensites in the image
%%
%
[hist_counts, edges] = imhist(img,256);
cdf = cumsum(hist_counts)/sum(hist_counts);
end