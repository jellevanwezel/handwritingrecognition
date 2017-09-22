function [ d ] = Mahalanobis( x, data )
d = pdist2(data,x,'mahalanobis');
end

