clear;
dataDir = '../../dataset/Train/';
outputDir = strcat(dataDir,'../Train_rotated/');
mkdir(outputDir);
dirContents = dir(dataDir);
%for i = 1:size(dirContents,1)
for i = 3:20
    fileName = dirContents(i).name;
    
    if ~all(fileName(end-3:end) == '.pgm')
        continue;
    end
    
    A = imread(strcat(dataDir,fileName));
    A = seg_binairy(A);
    [A,angle] = seg_rotation(A);
    imwrite(A,strcat(outputDir,fileName(1:end-3),'_r',num2str(angle),'.png'));    
end