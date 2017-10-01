%Improvised knn script
%This is leave one out.
%Follow the instructions in the code


clear;
load('/home/jelle/RUG/HR/dataset/labeled/sobel.mat');
%load('/home/jelle/RUG/HR/dataset/labeled/prewit.mat');
%load('/home/jelle/RUG/HR/dataset/features/base_dataset_prewit.mat');
%load('/home/jelle/RUG/HR/dataset/features/base_dataset.mat');
%features = data;

%distanceMeasures = {'euclidean','mahalanobis','minkowski','cosine',};
distanceMeasures = {'euclidean'};


maxK = 5;
k = 1:maxK;

%features = normc(features); %dont do this for Mahalanobis normalizing for
features = fn_pre_normalized_var( features );
% Mahalanobis is bs

prevP = 0;
for methodIdx = 1 : length(distanceMeasures)
    distanceMeasure = distanceMeasures{methodIdx};
    disp(distanceMeasure);
    hits = zeros(maxK,1);
    for i = 1:length(features)

        tempFeatures = features;
        tempLabels = labels;

        tempFeatures(i,:) = [];
        tempLabels(i) = [];

        label = labels(i);
        x = features(i,:);

        foundLabels = knn(k,x,tempFeatures,tempLabels,distanceMeasure);

        hits = hits + (foundLabels == label);


        nextP = floor((i + ((methodIdx - 1) * length(features)))  / (length(features) * length(distanceMeasures)) * 100);
        if nextP > prevP
            prevP = nextP;
            disp([num2str(prevP), '%']);
        end
    end
    hitRates = hits/length(features);
    %save(['/home/jelle/RUG/HR/dataset/errorRates/knn_',distanceMeasure,'_base_sobel.mat'],'hitRates');
end
