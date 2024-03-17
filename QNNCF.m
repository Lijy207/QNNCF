function [ R,num,time ] = QNNCF( X,Y,para )
%% Initialization
tic;
[n,d] = size(X);
[m,~] = size(Y);
lambda1 = para.lambda1;
lambda2 = para.lambda2;
fea = para.fea;
Y(:,fea:d) = 0;
%% Random initialization variable
alpha = rand(n,m);
iter = 1;
obji = 1;
time1 =toc;
%% Iterative optimization
while 1
    %%  updata alpha
    dn = 0.5./(sqrt(sum(alpha.*alpha,2)+eps));
    U = diag(dn);
    for j =1:m
        DN{j} = 0.5./(sqrt(sum(alpha(:,j).*alpha(:,j),2)+eps));
        D{j} = diag(DN{j});
        alpha = pinv(X*X'+lambda1*U+lambda2*D{j})*(X*Y');
    end
    alphai = sqrt(sum(alpha.*alpha,2)+eps);
    alpha21 = sum(alphai);
    %      obj(iter) =  norm(Y' - X'*alpha, 'fro')^2  +  lambda1 * alpha21 + lambda2*sum(alpha(:));
    %      cver = abs((obj(iter)-obji)/obji);
    %      obji = obj(iter);
    iter = iter + 1;
    %     if iter == 20,    break,     end
    if (iter > 2) || iter == 5,    break,     end
end
%  flagP = 1;
%  if flagP == 1,  plot(obj), end
tic;
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
time2 = toc;
time = time1 + time2;
end



