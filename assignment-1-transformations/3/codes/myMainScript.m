%% MyMainScript
%
%% Part-(c)
%   Consider an image whose histogram is biased toward one of the
%   extremes(high number of bright pixels or high number of dark pixels).
%   In such images, we would like to preserve the characteristic brightness
%   of the image even though it's skewed and uniform cdf might not be
%   preferred.
%   When we use Histogram Equalization, it results in a mean intensity of 
%   255/2 theoretically. This means that the original mean intensity of the
%   image is not preserved. Whereas, the current method preserves this
%   mean. This is evident from the result in part-b of Question 3, where
%   the mean intensity comes out to be (original_mean + 1/2)/2. This final
%   mean lies between the original mean and the 1/2 seen in Histogram
%   equalization and thus the characteristic brightness is preserved. This
%   is evident from our experiments on the statue.png image.
%
%   Refer [https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=580378]

tic;
%% Part-(d)
myBiHE();
toc;
