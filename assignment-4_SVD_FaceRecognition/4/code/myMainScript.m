%% MyMainScript

tic;
%% Your code here
A = reshape((1:12), 4, 3);
[U, S, V] = mySVD(A);
disp(U*S*V');
[U1, S1, V1] = svd(A, 'econ');
disp(U1*S1*V1');
toc;
