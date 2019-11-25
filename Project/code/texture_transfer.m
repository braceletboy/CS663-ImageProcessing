function transfer_image = texture_transfer(texture_image, target_image,...
                                           patch_size, threshold_factor,...
                                           num_iters,overlap_factor)
%%
%
%%
%
[m,n,~] = size(target_image);
input_image = target_image;
% alpha = 0.5;
w = patch_size*(1-overlap_factor);
o = round(patch_size*overlap_factor);
m1 = floor((m-o)/w)*w+o;
n1 = floor((n-o)/w)*w+o;
% disp(w);
% disp(o);
% disp(m1);
% disp(n1);

for iter=1:num_iters
    fprintf("Iteration No: %i .........START\n", iter);
    if(num_iters == 1)
        alpha = 0.5;
    else
        alpha = 0.8*(iter-1)/(num_iters-1) + 0.1;
    end
    output_image = transfer_quilting(m1,n1,o,w,texture_image, input_image,...
                                     patch_size, threshold_factor,...
                                     alpha,overlap_factor);
    
    input_image = output_image;
    [m,n,~] = size(input_image);
    m1 = floor((m-o)/w)*w+o;
    n1 = floor((n-o)/w)*w+o;
    fprintf("Iteration No: %i .........DONE\n", iter);
end
transfer_image = output_image;
end