function [ label ] = knn(k, x, data, labels )
distances = sqrt((data - repmat(x,size(data,1),1)).^2) ;
sorted = sortrows([distances,labels],1);
label = mode(sorted(1:k,2),1);
end

