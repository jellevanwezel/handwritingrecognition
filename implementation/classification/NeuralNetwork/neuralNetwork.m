function [percentageCorrectly, s] = neuralNetwork (s)

  
count = 0;

while count < s.epochs

    % Increment loop counter
    count = count + 1

    % Iterate through all examples
    TrainError = 0;
    for i=1:length(s.trainFeatures(1,:))
        % Input data from current example set
        input = s.trainFeatures(:,i);
        input(end+s.bias) = s.bias;
        currentLabel = s.trainLabels(:,i).';
        desiredOutput = zeros(length(s.uniqueLabels), 1);
        desiredOutput(find(strcmp(s.uniqueLabels, currentLabel))) = 1;

        % Propagate the signals through network
        hiddenActivation = actFunc(s.hiddenWeights*input);
        outputActivation = actFunc(s.outputWeights*hiddenActivation);
       
        TrainError = TrainError + sum(((desiredOutput-outputActivation).^2));
        % Output layer error
        delta_i = outputActivation.*(ones(length(s.uniqueLabels),1)-outputActivation).*(desiredOutput-outputActivation);

        % Calculate error for each node in layer_(n-1)
        delta_j = hiddenActivation.*(1-hiddenActivation).*(s.outputWeights.'*delta_i);

        % Adjust weights in matrices sequentially
        s.outputWeights = s.outputWeights + s.learningRate.*delta_i*(hiddenActivation.');
         s.hiddenWeights = s.hiddenWeights + s.learningRate.*delta_j*(input.');
    end
    
 
    s.trainMSE(count) = TrainError/(2*length(s.trainFeatures(1,:)));

end


classified = 0;
testError = 0;   

for i=1:length(s.testFeatures(1,:))
    input = s.testFeatures(:,i);
    input(end+s.bias) = s.bias;
    currentLabel = s.testLabels(:,i).';
    
    desiredOutput = zeros(length(s.uniqueLabels), 1);
    desiredOutput(find(strcmp(s.uniqueLabels, currentLabel))) = 1;
    desiredOutputClass = find(strcmp(s.uniqueLabels, currentLabel));
    
    hiddenActivation = actFunc(s.hiddenWeights*input);
    outputActivation = actFunc(s.outputWeights*hiddenActivation);
    outputClass = find(outputActivation==max(outputActivation));
    
    testError = testError + sum(((desiredOutput-outputActivation).^2));
    if outputClass == desiredOutputClass
        outputActivation
        outputClass
        classified = classified + 1;
    end
        
end
    
s.testMSE = testError/length(s.testFeatures(1,:));

percentageCorrectly = (classified/length(s.testFeatures(1,:)))*100;


