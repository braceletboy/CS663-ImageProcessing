function transfer_image = texture_transfer(texture_image, target_image,...
                                           patch_size, threshold_factor,...
                                           num_iters)
%%
%
%%
%
input_image = target_image;
[~, m, ~] = size(target_image);
alpha = 0.5;
for iter=1:num_iters
    quilt_multiple = int64((((6*m)/patch_size)-1)/5);
%     disp("quilt_m");
%     disp(quilt_multiple);
    
    fprintf("Iteration No: %i .........START\n", iter);
%     if(num_iters == 1)
%         alpha = 0.5;
%     else
%         alpha = 0.8*(iter-1)/(num_iters-1) + 0.1;
%     end
    output_image = transfer_quilting(texture_image, input_image,...
                                     patch_size, threshold_factor,...
                                     quilt_multiple, alpha);
    patch_size = int64(patch_size/2);
    input_image = output_image;
    fprintf("Iteration No: %i .........DONE\n", iter);
end
transfer_image = output_image;
end