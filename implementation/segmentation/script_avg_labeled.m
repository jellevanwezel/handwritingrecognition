%%
clear;
labelsLoc = '../../dataset/labeled/';
lineDirs = dir(labelsLoc);
nDirs = length(lineDirs);
widths = [];
for i=3:nDirs %%% aanpassen in nSentences voor alle data
    
   dirName = lineDirs(i).name;
   labeledFileNames = dir(strcat(labelsLoc,dirName,'/','*.png'));
   nfiles = length(labeledFileNames);
   
   for j = 1:nfiles
       
       imageName = labeledFileNames(j).name;
       width = str2double(regexp(imageName, '(?<=w=)[0-9]+', 'match'));
       widths = [widths;width];
   end
    
end

mean = mean(widths)
std = std(widths)
