% Before running, make sure your dataset is in ../../dataset/Train/
% Also make sure you have /implementation/segmentation as your working
% directory

clear;
dataDir = '../../dataset/Train_segmented/';
outputDir = strcat(dataDir,'../Train_split_big/');
mkdir(outputDir);
dirContents = dir(dataDir);

meanWidth = 73.5944; % Mean width calculated from the labeled data
stdWidth = 8.4463; % std in width calculated from the labeled data

for i = 3:size(dirContents,1)    
    if ~dirContents(i).isdir
        continue;
    end
    
    folderName = dirContents(i).name;
    folderPath = [dataDir,folderName,'/'];
    folderDir = dir(folderPath);
    
    for j = 3:size(folderDir,1)
        
        fileName = folderDir(j).name;
        if ~all(fileName(end-3:end) == '.png')
            continue;
        end 
                
        A = imread(strcat(folderPath,fileName));      
        if size(A,2) < meanWidth + 3 * stdWidth
            continue;
        end
                
        splitted = seg_split_big(A,meanWidth,stdWidth,10);
        
        if size(splitted,2) == 1
           %image not splitted
           continue;
        end
        outputPath = [outputDir,folderName,'/',fileName,'/'];
        mkdir(outputPath); 
        
        for k = 1:length(splitted)
            imageSplit =  splitted{k};
            imwrite(imageSplit,strcat(outputPath,'split_',num2str(k),'.png'));
            disp(['splitted:', num2str(k),'.png', ' of ', fileName])
        end
    end
end