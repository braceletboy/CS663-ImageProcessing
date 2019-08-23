function enlarged_image = myNearestNeighborInterpolation()
%% Perform Nearest Neighbor Interpolation on the given image.
%
% SYNTAX:
%   enlarged_image = myNearestNeighborInterpolation()
%
% OUTPUT:
%   enlarged_image = The enlarged image
image = imread("../data/barbaraSmall.png");
[num_rows,num_columns] = size(image);
image = double(image)/255;
enlarged_image = double(zeros([3*num_rows-2, 2*num_columns-1]));

for i = 1:3:3*num_rows-2
    for j = 1:2:2*num_columns-1
        enlarged_image(i,j) = image((i-1)/3 + 1,(j-1)/2 + 1);
    end
end

for i = 1:3*num_rows-2
    for j = 1:2*num_columns-1
        if rem(i,3)==1
            if rem(j,2)==0
                enlarged_image(i,j) = (enlarged_image(i,j-1)+ ...
                    enlarged_image(i,j+1))/2;
            end
        elseif rem(i,3)==2
            if rem(j,2)==1
                enlarged_image(i,j) = enlarged_image(i-1,j);
            else
                enlarged_image(i,j) = (1/2*enlarged_image(i-1,j-1) + ...
                    1/2*enlarged_image(i-1,j+1));
            end
        else
            if rem(j,2)==1
                enlarged_image(i,j) = enlarged_image(i+1,j);
            else
                enlarged_image(i,j) = (1/2*enlarged_image(i+1,j-1) + ...
                    1/2*enlarged_image(i+1,j+1));
            end
        end
    end
end

figure;
pixel_index = imref2d(size(image));
subplot(1,2,1), imshow(image,pixel_index);
colorbar;
pixel_index = imref2d(size(enlarged_image));
subplot(1,2,2), imshow(enlarged_image,pixel_index);
colorbar;
end