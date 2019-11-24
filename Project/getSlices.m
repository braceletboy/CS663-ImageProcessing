function [blocks] = getSlices(texture_img,k)
% non overlapping adjacent patches

[m,n] = size(texture_img);
blocks = [];
for i = 1:k:m-k+1
    for j = 1:k:n-k+1
        blocks = cat(3,blocks,texture_img(i:i+k-1,j:j+k-1));
    end
end



        
        