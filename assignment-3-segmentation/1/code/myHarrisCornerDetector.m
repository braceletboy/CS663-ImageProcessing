function corners = myHarrisCornerDetector(eig_min, eig_max, corn_k, threshold)

    [rows, columns] = size(eig_min);
    %% cornerness
    corners = eig_min.*eig_max - corn_k*((eig_min + eig_max).^2);
    corners(corners < threshold) = 0;
    
    %% Non-Maximal supression
    for i=2:2:rows-2
        for j=2:2:columns-2
            corners(i-1:i+1,j-1:j+1)=(corners(i-1:i+1,j-1:j+1) == ...
                            max(max(corners(i-1:i+1,j-1:j+1))))*max(max(corners(i-1:i+1,j-1:j+1)));
        end
    end
    
    corners = (corners > 0);
end