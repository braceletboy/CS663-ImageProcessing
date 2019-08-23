function shrunken_image = myShrinkImageByFactorD(shrink_factor)
%% Shrink circles_concentric.png image by the given factor
%
% SYNTAX:
%   shrunken_image = myShrinkImageByFactor(shrink_factor);
%
% INPUT:
%   shrink_factor = The factor by which we need shrink it
%
% OUTPUT:
%   shrunken_image = The image after being shrunk
%
%%
%
image = imread('../data/circles_concentric.png');
shrunken_image = image(shrink_factor:shrink_factor:end, ...
                        shrink_factor:shrink_factor:end);
figure('Name', 'Original vs Shrunken');
subplot(1,2,1), imshow(image);
colorbar;
subplot(1,2,2), imshow(shrunken_image);
colorbar;
end