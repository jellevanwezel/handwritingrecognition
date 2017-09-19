function [ label ] = knn(k, x, data, labels, distM)
distFunc = str2func(distM);
distances = distFunc(x,data) ;

sorted = sortrows([distances,labels],1);
label = mode(sorted(1:k,end),1);
end

