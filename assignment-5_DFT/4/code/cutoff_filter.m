function [filtered_img, lp_filter] = cutoff_filter(img, cutoff)
%%  Low pass filter that cut's off at the given frequency
%
% SYNTAX:
%   filtered_img = low_pass_filter(img);
%
% INPUTS:
%   img = The image to be filtered.
%   cutoff = The cutoff frequency for the filter.
%
% OUPUT:
%   filtered_img = The image after filtering.
%   lp_filter = The low pass filter
%
%%
%
[num_rows, num_columns] = size(img);
shifted_fft_img = fftshift(fft2(img));
lp_filter = zeros(num_rows, num_columns);
lp_filter(0.5*num_rows - cutoff : 0.5*num_rows + cutoff, ...
    0.5*num_columns - cutoff : 0.5*num_columns + cutoff) = 1;
filtered_fft_img = shifted_fft_img.*lp_filter;
filtered_img = abs(ifft2(ifftshift(filtered_fft_img)));
end