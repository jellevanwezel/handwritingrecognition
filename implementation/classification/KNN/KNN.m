function [correctlyClassified, s] = KNN(s, par)

if par.importKNNmodel
    model = importdata('KNNmodel.mat'); 
elseif par.tenfoldcross
    model = fitcknn(s.features', s.labels, 'NumNeighbors', par.numOfNeighbors, 'Standardize',1);
    save('KNNmodel.mat', 'model'); 
elseif par.splitTrainTest
    model = fitcknn(s.trainFeatures', s.trainLabels, 'NumNeighbors',par.numOfNeighbors, 'Standardize',1);
    save('KNNmodel.mat', 'model'); 
end
model

if par.tenfoldcross
    %Calculate misclassification error
    cvmodel = crossval(model,'kfold',10)
    cvError = kfoldLoss(cvmodel);
    %cvError = kfoldLoss(cvmodel, 'mode', 'individual')

    %Generate confusion matrix    
    %predictedLabels = predict(model,s.features');
    %R = confusionmat(predictedLabels, s.labels);
    %save('confusionmat.mat', 'R');
    correctlyClassified = (1-cvError)*100
elseif par.splitTrainTest
    predictedLabels = predict(model, s.testFeatures');
    correct = 0;
    
    for i = 1:length(s.testLabels)
        if(strcmp(predictedLabels(i), s.testLabels(i)))
            correct = correct + 1;
        else
            predictedLabels(i);
        end
    end
    correctlyClassified = (correct/length(s.testLabels))*100
end

