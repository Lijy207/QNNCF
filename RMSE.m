function [ RMSE ] = RMSE( R,C,num )

RMSE = sqrt(sum(sum((R-C).^2))).*sqrt(1/num)

end

