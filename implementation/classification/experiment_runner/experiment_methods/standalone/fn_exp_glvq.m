function [ results ] = fn_exp_glvq( dataset, glvqParams )

trainData = dataset.trainData;
trainLabels = dataset.trainLabels;
testData = dataset.testData;
testLabels = dataset.testLabels;

%classes = length(unique([trainLabels;testLabels]));
% Do experiment

initialMatrix = eye(size(trainData,2));
if(isfield(glvqParams, 'initialMatrix'))
    initialMatrix = glvqParams.initialMatrix;
end
    

[GLVQ_model,GLVQ_settting, ~, ~, costs] = GMLVQ_train(trainData, trainLabels,...
    'dim',size(trainData,2),...
    'regularization',glvqParams.regularization,...
    'initialMatrix',initialMatrix,...
    'learningRateMatrix', @(x) 0, ...
    'MaxIter', glvqParams.MaxIter, ...
    'PrototypesPerClass', glvqParams.PrototypesPerClass ...
    );

GLVQ_model.costs = costs;

estimatedTrainLabels = GMLVQ_classify(trainData, GLVQ_model);
trainError = mean( trainLabels ~= estimatedTrainLabels );

estimatedTestLabels = GMLVQ_classify(testData, GLVQ_model);
testError = mean( testLabels ~= estimatedTestLabels );

results = struct('GLVQ_model',GLVQ_model,'GLVQ_setting',GLVQ_settting,'trainError',trainError,'testError',testError);
end

