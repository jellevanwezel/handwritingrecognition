%Improvised knn script
%This is leave one out.
%Follow the instructions in the code


clear;
%load('/home/jelle/RUG/HR/dataset/labeled/sobel.mat');
load('/home/jelle/RUG/HR/dataset/labeled/prewit.mat');
%load('/home/jelle/RUG/HR/dataset/features/base_dataset.mat');
%features = data;


maxK = 20;
ks = 1:maxK;

%features = normc(features); %dont do this for Mahalanobis normalizing for
% Mahalanobis is bs

prevP = 0;
for p = 3 : 22
    hits = zeros(maxK,1);
    for i = 1:length(features)

        tempFeatures = features;
        tempLabels = labels;

        tempFeatures(i,:) = [];
        tempLabels(i) = [];

        label = labels(i);
        x = features(i,:);
        
        distances = pdist2(tempFeatures,x,'minkowski',p);
        sorted = sortrows([distances,tempLabels],1);
        foundLabels = nan(size(ks,2),1);
        for kIdx = 1:size(ks,2)
            k = ks(1,kIdx);
            foundLabels(kIdx) = mode(sorted(1:k,end),1);
        end
        

        hits = hits + (foundLabels == label);


        nextP = floor(i / (length(features) * 20) * 100);
        if nextP > prevP
            prevP = nextP;
            disp([num2str(prevP), '%']);
        end
    end
    hitRates = hits/length(features);
    save(['/home/jelle/RUG/HR/dataset/errorRates/knn_MINKOWSKI_',num2str(p),'_prewit.mat'],'hitRates');
end
