function [ results ] = fn_exp_gmlvq( dataset, gmlvqParams)
    
trainData = dataset.trainData;
trainLabels = dataset.trainLabels;
testData = dataset.testData;
testLabels = dataset.testLabels;

if isempty(gmlvqParams.initialMatrix)
    gmlvqParams.initialMatrix = eye(size(trainData,2));
end

% Do experiment

% Todo: fix the struct here to pass all parameters

[GMLVQ_model,GMLVQ_settting, ~, ~, costs] = GMLVQ_train(trainData, trainLabels,...
    'dim',size(trainData,2),...
    'PrototypesPerClass',gmlvqParams.PrototypesPerClass,...
    'regularization',gmlvqParams.regularization,...
    'initialMatrix',gmlvqParams.initialMatrix,...
    'nb_epochs', gmlvqParams.nb_epochs ...
    );
GMLVQ_model.costs = costs;

estimatedTrainLabels = GMLVQ_classify(trainData, GMLVQ_model);
trainError = mean( trainLabels ~= estimatedTrainLabels );

estimatedTestLabels = GMLVQ_classify(testData, GMLVQ_model);
testError = mean( testLabels ~= estimatedTestLabels );



results = struct('GMLVQ_model',GMLVQ_model,'GMLVQ_setting',GMLVQ_settting,'trainError',trainError,'testError',testError);

end

