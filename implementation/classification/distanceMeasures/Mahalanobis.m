function [ d ] = Mahalanobis( x, data )
sigma = cov(data);
di = data - repmat(x,size(y,1),1);
d = sqrt(di' * inv(sigma) * di);
end

