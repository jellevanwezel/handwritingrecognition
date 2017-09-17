clear;
load('/home/jelle/RUG/HR/dataset/labeled/sobel.mat');

errorRates = nan(20,1);
errorRates(1:6,1) = [0.827533009664685;0.725214392667544;0.672035936294750;0.638368347021190;0.630836244838695;0.627115567856981];
features = normc(features);

for k = 7:20
    
    hit = 0;
    
    prevP = 0;
    
    for i = 1:length(features)
        
        tempFeatures = features;
        tempLabels = labels;
        
        tempFeatures(i,:) = [];
        tempLabels(i) = [];
        
        label = labels(i);
        x = features(i,:);
        
        foundLabel = knn(k,x,tempFeatures,tempLabels);
        
        if foundLabel == label
            hit = hit + 1;
        end
        
        nextP = floor(i / length(features) * 100);
        if nextP > prevP
            prevP = nextP;
            disp(['pass:', num2str(k),' - ', num2str(prevP), '%']);
        end
    end
    errorRates(k) = hit/length(features);
end
