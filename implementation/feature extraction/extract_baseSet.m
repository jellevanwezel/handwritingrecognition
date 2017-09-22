clear;

outputPath = '/home/jelle/RUG/HR/dataset/features/';
labeledSet = '/home/jelle/RUG/HR/dataset/labeled/baseSet.mat';

mkdir(outputPath);
load(labeledSet);

disp('Mapping labels');

labelMap = labelMapper(labelSet);

disp('Extracting features');
data = nan(length(charSet),22);
labels = nan(length(charSet),1);

prevP = 0;
    
for i = 1:length(charSet)

    I = charSet{i};
    I = I /max(I(:));
    if size(I,1) <= 1 || size(I,2) <=1
        continue;
    end

    if floor(i / length(charSet) * 100) > prevP
        prevP = floor(i/length(charSet) * 100);
        disp([num2str(prevP), ' %']);
    end

    data(i,:) = extract_features(I,'sobel');
    labels(i,1) = getfield(labelMap,['l',labelSet{i}]);
end

save([outputPath,'base_dataset.mat'],'data','labels');

