clear;

datasetPath = '/home/jelle/RUG/HR/dataset/Train_segmented_run_4t/';
outputPath = '/home/jelle/RUG/HR/dataset/features/';
mkdir(outputPath);

%include paths

dataSet = dir(datasetPath);
disp('Indexing Chars');
nChars = 0;
for lineIdx = 3:size(dataSet,1)
    lineFolderName = dataSet(lineIdx).name;
    lineFolderPath = [datasetPath,'/',lineFolderName];
    nChars = nChars + size(dir(lineFolderPath),1) - 2;
end

disp([num2str(nChars), ' found']);
disp('Extracting features');
features = nan(nChars,22);
names = cell(nChars,1);

prevP = 0;
charNumber = 0;

for lineIdx = 3:size(dataSet,1)
    
    lineFolderName = dataSet(lineIdx).name;
    lineFolderPath = [datasetPath,'/',lineFolderName];
    
    lineDir = dir(lineFolderPath);
    
    for charIdx = 3:size(lineDir,1)
        
        charFileName = lineDir(charIdx).name;
        charPath = [lineFolderPath,'/',charFileName];
        
        I = imread(charPath);
        I = I /max(I(:));
        if size(I,1) <= 1 || size(I,2) <=1
            continue;
        end
        
        charNumber = charNumber + 1;
        
        if floor(charNumber / nChars * 100) > prevP
            prevP = floor(charNumber/nChars * 100);
            disp([num2str(prevP), ' %']);
        end
        
        features(charNumber,:) = extract_features(I,'sobel'); 
        % todo, find the size of the dataset
        names{charNumber} = [lineFolderName,'_FILE_',charFileName(1:end-4)];
    end
end

save([outputPath,'dataset.mat'],'features','names');

