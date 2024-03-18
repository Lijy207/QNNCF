%% We used the mobile dataset to test the algorithm we proposed.
clear;clc;
document = {'mobileDataset'};
FileName = [char(document) '.mat'];
load(FileName);
X = double(X);
[nn,dd] = size(X);
X=NormalizeFea(X,0);
%% Set parameter values.
para.lambda1 = 10;
para.lambda2 = 10;
para.fea = ceil(0.9*dd);
%%  We use ten-fold cross-validation to split the dataset.
ind(:,1) = crossvalind('Kfold',nn,10);
%% We train and predict on each fold of the data in sequence using the proposed algorithm.
for k = 1:10
    test = ind(:,1) == k;
    train = ~test;
    [ R,num,time ] = QNNCF( X(train,:),X(test,:),para );
    RMSE1(k)  = RMSE(R,X(test,:),num);
    MAE1(k)  = MAE(R,X(test,:),num);
    Time(k) = time;
end

ACCRMSE = mean(RMSE1);
ACCMAE = mean(MAE1);
sumTime = sum(Time);

fprintf('The RMSE is %8.5f\n',RMSE1)
fprintf('The MAE is %8.5f\n',MAE1)
fprintf('The Average RMSE is %8.5f\n',ACCRMSE)
fprintf('The Average MAE is %8.5f\n',ACCMAE)
fprintf('The running cost is %8.5f\n',sumTime)





