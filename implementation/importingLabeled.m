clear all;

cd('..');
cd('dataset');
cd('labeled');

count=1;
totallength=0;

start_path = pwd;


allSubFolders = genpath(start_path);

remain = allSubFolders;
listOfFolderNames = {};

% Parse all foldernames
while true
	[singleSubFolder, remain] = strtok(remain, ';');
	if isempty(singleSubFolder)
		break;
	end
	listOfFolderNames = [listOfFolderNames singleSubFolder];
end


numberOfFolders = length(listOfFolderNames)

restoredefaultpath


%% Loop through the folders
for k = 2 : numberOfFolders
    
	% Get this folder and print it out.
	thisFolder = listOfFolderNames{k};
	%fprintf('Processing folder %s\n', thisFolder);
    
    k
	filePattern = sprintf('%s/*.png', thisFolder);
	baseFileNames = dir(filePattern);
    
	numberOfImageFiles = length(baseFileNames);
   
    for i=1:numberOfImageFiles
        
        %Images
        addpath(thisFolder);
        name = baseFileNames(i).name;
        allImages{count} = imread(name);     
        rmpath(thisFolder); 
        
        %Labels
        labels{count} = regexp(name,'(?<=l=)[0-9]+\w*' ,'match');
        
        count = count+1;         
    end   
 
end

cd('..');
cd('..');
cd('implementation');

save('labeledSigns.mat', 'allImages'); 
save('labels.mat', 'labels');