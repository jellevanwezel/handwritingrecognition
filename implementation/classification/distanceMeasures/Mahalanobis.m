function [ output_args ] = Mahalanobis( x, data, sigma )
di = data - repmat(x,size(y,1),1);
d = sqrt(di' * inv(sigma) * di);
end

