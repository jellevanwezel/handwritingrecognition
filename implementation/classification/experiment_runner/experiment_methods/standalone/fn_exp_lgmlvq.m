function [ results ] = fn_exp_lgmlvq( dataset, lgmlvqParams)
    
trainData = dataset.trainData;
trainLabels = dataset.trainLabels;
testData = dataset.testData;
testLabels = dataset.testLabels;

if isempty(lgmlvqParams.initialMatrices)
    lgmlvqParams.initialMatrices = cell(size(trainData,2),1);
    for i = 1:size(trainData,2)
        lgmlvqParams.initialMatrices{i,1} = eye(size(trainData,2));
    end
end

% Do experiment

[LGMLVQ_model,LGMLVQ_settting,~,~,costs] = LGMLVQ_train(trainData, trainLabels,...
    'dim',size(trainData,2),...
    'PrototypesPerClass',lgmlvqParams.PrototypesPerClass,...
    'regularization',lgmlvqParams.regularization,...
    'initialMatrices',lgmlvqParams.initialMatrices,...
    'MaxIter', lgmlvqParams.MaxIter ...
    );
LGMLVQ_model.costs = costs;

estimatedTrainLabels = LGMLVQ_classify(trainData, LGMLVQ_model);
trainError = mean( trainLabels ~= estimatedTrainLabels );

estimatedTestLabels = LGMLVQ_classify(testData, LGMLVQ_model);
testError = mean( testLabels ~= estimatedTestLabels );

results = struct('lGMLVQ_model',LGMLVQ_model,'lGMLVQ_setting',LGMLVQ_settting,'trainError',trainError,'testError',testError);

end

