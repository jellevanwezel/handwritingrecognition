function [correctlyClassified, s] = KNN(s, par, status)

if status == 'onlyTrain'
    model = fitcknn(s.features', s.labels, 'NumNeighbors', par.numOfNeighbors, 'Standardize',1);
    save('KNNmodel.mat', 'model'); 
elseif status == 'onlyClassify'
    model = importdata('KNNmodel.mat'); 
    if par.tenfoldcross
        %Calculate misclassification error
        cvmodel = crossval(model,'kfold',10)
        cvError = kfoldLoss(cvmodel);
        correctlyClassified = (1-cvError)*100
        %Generate confusion matrix    
        %%predictedLabels = predict(model,s.features');
        %%R = confusionmat(predictedLabels, s.labels);
        %%save('confusionmat.mat', 'R');
    else
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
elseif status == 'trainAndClassify'
    if par.tenfoldcross 
        model = fitcknn(s.features', s.labels, 'NumNeighbors', par.numOfNeighbors, 'Standardize',1);
        %Calculate misclassification error
        cvmodel = crossval(model,'kfold',10)
        cvError = kfoldLoss(cvmodel);
        correctlyClassified = (1-cvError)*100
        %Generate confusion matrix    
        %%predictedLabels = predict(model,s.features');
        %%R = confusionmat(predictedLabels, s.labels);
        %%save('confusionmat.mat', 'R');
    else
        model = fitcknn(s.trainFeatures', s.trainLabels, 'NumNeighbors',par.numOfNeighbors, 'Standardize',1);
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
end



 
 
    
end

