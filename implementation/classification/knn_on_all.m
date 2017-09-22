%Improvised knn script
%This is leave one out.
%Follow the instructions in the code


clear;
load('/home/jelle/RUG/HR/dataset/labeled/sobel.mat');

%distanceMeasure = 'Euclidian';
distanceMeasure = 'Mahalanobis';
maxK = 20;

k = 1:maxK;

% features = normc(features); %dont do this for Mahalanobis normalizing for
% Mahalanobis is bs
    
hits = zeros(maxK,1);

prevP = 0;

for i = 1:length(features)

    tempFeatures = features;
    tempLabels = labels;

    tempFeatures(i,:) = [];
    tempLabels(i) = [];

    label = labels(i);
    x = features(i,:);

    foundLabels = knn(k,x,tempFeatures,tempLabels,distanceMeasure);
    
    hits = hits + (foundLabels == label);
    

    nextP = floor(i / length(features) * 100);
    if nextP > prevP
        prevP = nextP;
        disp([num2str(prevP), '%']);
    end
end
hitRates = hits/length(features);
