function [ output_args ] = classification( features, labels )

% Normalize features
normFeatures = features - min(features(:));
normFeatures = normFeatures ./ max(normFeatures(:)); % *

% Percentage train instances
perTrain = 0.72;

s.trainFeatures = normFeatures(:, 1:(perTrain*length(normFeatures)));
s.testFeatures = normFeatures(:, ((perTrain*length(normFeatures))+1):length(normFeatures));
s.trainLabels = labels(:, 1:(perTrain*length(normFeatures)));
s.testLabels = labels(:, ((perTrain*length(normFeatures))+1):length(normFeatures));
s.uniqueLabels = unique(labels);

% KNN
cd('KNN')
[correctlyClassified, s] = KNN(s);

% % Initialize network and set parameters
% s.bias=1.0;
% s.hiddenNodes = 225;
% s.hiddenWeights = rand(s.hiddenNodes, length(s.trainFeatures(:,1))+s.bias);
% s.outputWeights = rand(length(s.uniqueLabels), s.hiddenNodes);
% s.learningRate= 0.01;
% s.epochs = 10;
% 
% % Train and test network
% [correctlyClassified, s] = neuralNetwork(s);
% 
% correctlyClassified
% 
% plot(s.trainMSE);
% ylim([-1 3])
% s.testMSE
