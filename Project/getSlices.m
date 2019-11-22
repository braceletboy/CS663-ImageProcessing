%texture_image = [1 2 3 5 6 7; 4 5 6 2 3 4; 7 8 10 3 4 5; 7 8 10 3 4 5; 4 5 6 2 3 4;1 2 3 5 6 7 ];
function [blocks] = getSlices(texture_img,k)
[m,n] = size(texture_img);
blocks = [];
for i = 1:k:m
    for j = 1:k:n
        blocks = cat(3,blocks,texture_img(i:i+k-1,j:j+k-1));
    end
end



        
        