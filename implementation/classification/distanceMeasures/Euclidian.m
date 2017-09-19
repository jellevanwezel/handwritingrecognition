function [ d ] = Euclidian( x, y )
d = sqrt(sum((data - repmat(x,size(y,1),1)).^2,2));
end

