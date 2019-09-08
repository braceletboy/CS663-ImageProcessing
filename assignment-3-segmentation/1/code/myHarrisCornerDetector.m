function corners = myHarrisCornerDetector(eig_min, eig_max, corn_k, threshlod)
    %% cornerness
    corn_prop = eig_min.*eig_max - k.*((eig_min + eig_max).^2);
end