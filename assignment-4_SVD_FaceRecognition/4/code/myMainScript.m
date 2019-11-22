%% MyMainScript
tic;
%% Input matrix A
A = reshape((1:12), 3, 4);
[U, S, V] = MySVD(A);

%% Output
fprintf("Left singular vector U\n");
display(U);
fprintf("Right singular vector V\n");
display(V);
fprintf("Singular values matrix S\n");
display(S);

%% Crosscheck with inbuilt svd function
fprintf("MySVD(A) = \n");
disp(U*S*V');
[U1, S1, V1] = svd(A, 'econ');
fprintf("svd(A) = \n");
disp(U1*S1*V1');
toc;
