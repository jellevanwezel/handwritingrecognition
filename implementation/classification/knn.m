function [ label ] = knn(k, x, data, labels )

distances = sqrt(sum((data - repmat(x,size(data,1),1)).^2,2)) ;

sorted = sortrows([distances,labels],1);
label = mode(sorted(1:k,end),1);
end

