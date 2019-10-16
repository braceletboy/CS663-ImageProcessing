function [U, S, V] = MySVD(A)
% Here dimensions of U -> m*m, S -> m*n, V -> n*n
[U, D] = eig(A*A');
[~, Indices] = sort(diag(D), 'descend');
U = U(:, Indices);

[V, D] = eig(A'*A);
[~, Indices] = sort(diag(D), 'descend');
V = V(:, Indices);

% Observation
% A = U*S*V' ==> U'*A*V = U'*U*S*V'*V = S.
% Here S may contain negative values, hence for obtaining the standard
% results(i.e, S contains positive eigen values) we take the negative
% vectors of U corresponding to negative values in S.
S = U'*A*V;
[m,n] = size(S);

for i=1:1:min(m,n)
    if(S(i,i)<0)
        U(:,i) = -U(:,i);
    end 
end
S = abs(S);

% Other approach --> taking only the non-zero eigen values('r' no of values) and
% corresponding vectors, dimensions of U -> m*r, V -> n*r, S -> r*r
% [U, D] = eig(A*A');
% Indices = find(fix(diag(D)));
% D = diag(D);
% D = D(Indices);
% D = diag(D);
% U = U(:, Indices); %#ok<FNDSB>
% 
% [X, Indices] = sort(diag(D), 'descend');
% D = diag(X);
% U = U(:, Indices);
% S = D.^0.5;
% V = A'*U;

end