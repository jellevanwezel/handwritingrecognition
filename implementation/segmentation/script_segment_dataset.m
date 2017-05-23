% Before running, make sure your dataset is in ../../dataset/Train/
% Also make sure you have /implementation/segmentation as your working
% directory

meanWidth = 73.5944; % Mean width calculated from the labeled data
stdWidth = 8.4463; % std in width calculated from the labeled data

clear;
dataDir = '../../dataset/Train/';
outputDir = strcat(dataDir,'../Train_segmented/');
mkdir(outputDir);
dirContents = dir(dataDir);
for i = 3:size(dirContents,1)
    fileName = dirContents(i).name;
    
    if ~all(fileName(end-3:end) == '.pgm')
        continue;
    end
    
    A = imread(strcat(dataDir,fileName));
    
    %Binairize image
    binA = seg_binairy(A);
    
    %Rotate image
    [rotatedA,~] = seg_rotation(binA);
    
    %Crop image verticaly
    vCroppedA = seg_v_density(rotatedA,0);
    
    %Trim image horizontaly
    trimmedA = seg_trim_image(vCroppedA);

    %Find and merge components
    merged = seg_concomp(trimmedA);
    
    %Write to file
    imageDir = strcat(outputDir,fileName(1:end-4),'/');
    mkdir(imageDir);
    for j = 1:length(merged)
        I = abs(merged{j}-1);
        imwrite(I,strcat(imageDir,num2str(j),'.png'));
    end
end