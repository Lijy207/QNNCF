
clear;clc;
document = {'movies100k'};
FileName = [char(document) '.mat'];
load(FileName);

[nn,dd] = size(X);
X=NormalizeFea(X,0);
algorithm = {'RCF1'};

para.lambda = 10; %parameter lambda
para.fea = ceil(0.9*dd);


 ind(:,1) = crossvalind('Kfold',nn,10);

for i1 = 1:length(algorithm)
    para.algorithm = char(algorithm(i1));
    
        for k = 1:10
            test = ind(:,1) == k;
            train = ~test;          
            switch para.algorithm                
                case'RCF1'
                    [ R,num ] = RCF1( X(train,:),X(test,:),para );                               
            end
             RMSE1(k)  = RMSE(R,X(test,:),num);
             MAE1(k)  = MAE(R,X(test,:),num);
        end

 ACCRMSE = mean(RMSE1)
 ACCMAE = mean(MAE1)
    save([char(document),'_','new',char(algorithm(i1)),num2str(ACCRMSE ),'_','.mat'])
    
end

