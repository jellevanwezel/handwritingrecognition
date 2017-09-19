function [ dataset ] = fn_pre_splitter( data, labels )
    ranIndices =  randperm(size(data,1))';
    halfway =  size(data,1) - floor(size(data,1) / 10);
    
    trainData = data(ranIndices(1:halfway),:);
    trainLabels = labels(ranIndices(1:halfway),:);
    testData = data(ranIndices(halfway+1:end),:);
    testLabels = labels(ranIndices(halfway+1:end),:);
    
    dataset = struct('trainData',trainData, 'trainLabels', trainLabels, 'testData', testData, 'testLabels', testLabels);
end

