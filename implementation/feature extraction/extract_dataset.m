clear;

datasetPath = '/home/jelle/RUG/HR/dataset/Train_segmented_run_4/';
outputPath = '/home/jelle/RUG/HR/dataset/features/';
mkdir(outputPath);

%include paths

dataSet = dir(datasetPath);
features = [];
names = {};

for lineIdx = 3:10%size(dirContents,1)
    
    lineFolderName = dataSet(lineIdx).name;
    lineFolderPath = [datasetPath,'/',lineFolderName];
    
    lineDir = dir(lineFolderPath);
    
    for charIdx = 3:size(lineDir,1)
        
        charFileName = lineDir(charIdx).name;
        charPath = [lineFolderPath,'/',charFileName];
        
        I = imread(charPath);
        I = I /max(I(:));
        features = [features ; extract_features(I,'sobel')]; 
        % todo, find the size of the dataset
        names = [names;{[lineFolderName,'_FILE_',charFileName(1:end-4)]}];
    end
end

save([outputPath,'dataset.mat'],'features','names');

