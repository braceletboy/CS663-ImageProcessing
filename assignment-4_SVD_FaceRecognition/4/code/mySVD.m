function [U, S, V] = mySVD(A)
[U, D] = eig(A*A');
[~, Indices] = sort(diag(D), 'descend');
U = U(:, Indices);

[V, D] = eig(A'*A);
[~, Indices] = sort(diag(D), 'descend');
V = V(:, Indices);

% A=U*S*V' ==> U'*A*V = U'*U*S*V'*V = S. 
S = U'*A*V;
[m,n] = size(S);
for i=1:1:min(m,n)
    if(S(i,i)<0)
        U(:,i)=-U(:,i);
    end 
end
S = abs(S);

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