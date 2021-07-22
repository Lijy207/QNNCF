function [ MAE ] = MAE( R,C,num )

MAE = sum(sum((abs(R-C)))).*1/num


end

