function test_images = get_external_images(path)
    image_shape = [112,92];
    test_images = zeros(prod(image_shape),8*10);
    for idx = 33:40
        folder_path = sprintf('%ss%i/*.pgm', path, idx);
        files = dir(folder_path);
        for jdx = 1:length(files)
            image_path = sprintf('%ss%i/%s', path, idx, ...
                                 files(jdx).name);
            img = imread(image_path);
            img = double(img)/255;
            img_features = img(:);
            test_images(:,(idx-33)*length(files)+jdx) = img_features;
        end
    end
end