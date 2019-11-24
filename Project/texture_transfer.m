function transfer_image = texture_transfer(texture_image, target_image,...
                                           patch_size, threshold_factor,...
                                           num_iters)
%%
%
%%
%
input_image = target_image;
for iter=1:num_iters
    quilt_multiple = 3;
    fprintf("Iteration No: %i .........START\n", iter);
    alpha = 0.8*(iter-1)/(num_iters-1) + 0.1;
    output_image = transfer_quilting(texture_image, input_image,...
                                     patch_size, threshold_factor,...
                                     quilt_multiple, alpha);
    patch_size = patch_size/2;
    input_image = output_image;
    fprintf("Iteration No: %i .........DONE\n", iter);
end
transfer_image = output_image;
end