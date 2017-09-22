function [ labels ] = knn(ks, x, data, labels, distM)
distances = pdist2(data,x,distM);
sorted = sortrows([distances,labels],1);
labels = nan(size(ks,2),1);
for i = 1:size(ks,2)
    k = ks(1,i);
    labels(i) = mode(sorted(1:k,end),1);
end
end

