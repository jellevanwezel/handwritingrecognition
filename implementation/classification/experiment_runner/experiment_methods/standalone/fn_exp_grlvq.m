function [ results ] = fn_exp_grlvq( dataset, grlvqParams)

trainData = dataset.trainData;
trainLabels = dataset.trainLabels;
testData = dataset.testData;
testLabels = dataset.testLabels;

if(isempty(grlvqParams.initialRelevances)); grlvqParams.initialRelevances = ones(1,size(trainData,2));end;

% Do experiment

[GRLVQ_model,GRLVQ_settting,~,~,costs] = GRLVQ_train(trainData, trainLabels,...
    'regularization',grlvqParams.regularization,...
    'nb_epochs', grlvqParams.nb_epochs,...
    'initialRelevances',grlvqParams.initialRelevances ...
    );
GRLVQ_model.costs = costs;

estimatedTrainLabels = GRLVQ_classify(trainData, GRLVQ_model);
trainError = mean( trainLabels ~= estimatedTrainLabels );

estimatedTestLabels = GRLVQ_classify(testData, GRLVQ_model);
testError = mean( testLabels ~= estimatedTestLabels );

results = struct('GRLVQ_model',GRLVQ_model,'GRLVQ_setting',GRLVQ_settting,'trainError',trainError,'testError',testError);

end

