function [ R,num ] = RCF1( X,Y,para )
%% initialization
[n,d] = size(X);
[m,~] = size(Y);
lambda = para.lambda;
fea = para.fea;
Y(:,fea:d) = 0;


%% initialization
alpha = rand(n,m);
iter = 1;
obji = 1;
while 1
    %%  alpha
    dn = 0.5./(sqrt(sum(alpha.*alpha,2)+eps));
    U = diag(dn);
    alpha = inv(X*X'+lambda*U)*(X*Y');
    
    
    
    alphai = sqrt(sum(alpha.*alpha,2)+eps);
    alpha21 = sum(alphai);
    
    obj(iter) =  norm(Y' - X'*alpha, 'fro')^2  +  lambda * alpha21;
    
    cver = abs((obj(iter)-obji)/obji);
    obji = obj(iter);
    iter = iter + 1;
    if (cver < eps && iter > 2) || iter == 20,    break,     end
end
flagP = 1;
if flagP == 1,  plot(obj), end
R = Y;
num=0;
for i=1:m
    index = find(alpha(:,i)==max(alpha(:,i)));
    for j=fea:d
    if Y(i,j)==0 & X(index,j)~=0
        num=num+1;
    R(i,j) = X(index,j);
    end
end
end




