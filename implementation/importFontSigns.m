function [ fontSigns, labels ] = importFontSigns( folder )

cd('..');
cd('dataset');
cd(folder);

imageFiles = dir('*.jpg');
nSigns = length(imageFiles);

for i=1:nSigns
    i
   currentFileName = imageFiles(i).name;
   currentImage = imread(currentFileName);
   
   labels{i} = currentFileName; 
   fontSigns{i} = currentImage;
end

cd('..');
cd('..');
cd('implementation');

end

