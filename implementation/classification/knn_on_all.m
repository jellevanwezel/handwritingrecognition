%Improvised knn script
%This is leave one out.
%Follow the instructions in the code


clear;
load('/home/jelle/RUG/HR/dataset/labeled/sobel.mat');

%distanceMeasure = 'Euclidian';
distanceMeasure = 'Mahalanobis';


hitRates = nan(20,1);
% features = normc(features); %dont do this for Mahalanobis normalizing for
% Mahalanobis is bs

for k = 1:2 %k = 1 is heighes run for till k=20
    
    hit = 0;
    
    prevP = 0;
    
    for i = 1:length(features)
        
        tempFeatures = features;
        tempLabels = labels;
        
        tempFeatures(i,:) = [];
        tempLabels(i) = [];
        
        label = labels(i);
        x = features(i,:);
        
        foundLabel = knn(k,x,tempFeatures,tempLabels,distanceMeasure);
        
        if foundLabel == label
            hit = hit + 1;
        end
        
        nextP = floor(i / length(features) * 100);
        if nextP > prevP
            prevP = nextP;
            disp(['pass:', num2str(k),' - ', num2str(prevP), '%']);
        end
    end
    hitRates(k) = hit/length(features);
end
