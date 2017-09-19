clear;
labeledSet = '/home/jelle/RUG/HR/dataset/labeled/labeled.mat';
outPath = '/home/jelle/RUG/HR/dataset/labeled/sobel.mat';


load(labeledSet);

features = nan(length(labeledSet),22);
labelsAsString = labeledSet(:,2);
labelMap = labelMapper(labelsAsString);
labels = label_to_number(labelsAsString,labelMap);

prevP = 0;

for i = 1 : length(labeledSet)
    imageFileCell = labeledSet{i,1};
    imageFilePath = imageFileCell{1};
    
    I = imread(imageFilePath);
    I = I /max(I(:));
    
    if size(I,1) <= 1 || size(I,2) <=1
        continue;
    end
    
    features(i,:) = extract_features(I, 'sobel');
    
    nextP = floor(i / length(labeledSet) * 100);
    if nextP > prevP
        prevP = nextP;
        disp([num2str(prevP), '%']);
    end
    
end

save(outPath,'features','labels','labelMap');