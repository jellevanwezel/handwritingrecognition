function [ output_args ] = classification( features, labels, par)

% Normalize features
if par.normalizeFeatures
    s.features = features - min(features(:));
    s.features = s.features ./ max(s.features(:)); 
else
    s.features = features;
end

% Percentage train instances
s.labels = [labels{:}];
s.trainFeatures = s.features(:, 1:(par.perTrain*length(s.features)));
s.testFeatures = s.features(:, ((par.perTrain*length(s.features))+1):length(s.features));
s.trainLabels = s.labels(:, 1:(par.perTrain*length(s.features)));
s.testLabels = s.labels(:, ((par.perTrain*length(s.features))+1):length(s.features));
s.uniqueLabels = unique(s.labels);

% KNN
if par.classifier == 'KNN'
    cd('KNN')
    [correctlyClassified, s] = KNN(s, par);
end
% Initialize network and set parameters
% cd('NeuralNetwork');
% s.bias=1.0;
% s.hiddenNodes = 50;
% s.hiddenWeights = rand(s.hiddenNodes, length(s.trainFeatures(:,1))+s.bias);
% s.outputWeights = rand(length(s.uniqueLabels), s.hiddenNodes);
% s.learningRate= 0.1;
% s.epochs = 5;
% 
% % Train and test network
% [correctlyClassified, s] = neuralNetwork(s);
% 
% correctlyClassified
% 
% plot(s.trainMSE);
% ylim([-1 3])
% s.testMSE
