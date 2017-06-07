%% Run 1 dir on top of labeled
clear all;

count=1;
totallength=0;

cd('labeled')
start_path = pwd;
%topLevelFolder = uigetdir(start_path);


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




%% Loop through the folders
for k = 2 : numberOfFolders
    
	% Get this folder and print it out.
	thisFolder = listOfFolderNames{k};
	%fprintf('Processing folder %s\n', thisFolder);
    
	filePattern = sprintf('%s/*.png', thisFolder);
	baseFileNames = dir(filePattern);
    
	numberOfImageFiles = length(baseFileNames);

    for i=1:numberOfImageFiles
           
        % Text manipulation to get the right class
        
        %Images
        name = baseFileNames(i).name;
        allImages(count) = imread(name);
        [x1,y1,z1] = size(allImages(count));
        totallength = totallength + x1;  % Use y1 for width
        
        
        %Labels
        expression = '(?<=l=)\w*+-';
        regex(name,'[?<=l=][0-9]+','match')
        labels(count) = regexp(name,'expression','match');
 
        count++;
        
        
  
        % Check if all labels and images are correctly saved
        

           
    end   
    
end

% resize images to the same format
avglength = totallength / count;


for i=1:count % Count should be equal to total number of images in allImages array
  [x1,y1,z1] = size(allImages(count));
  resizedImage(count) = imresize(allImages(count), [avglength y1],'bilinear');  % Could change and experiment with the interpolation method
end 


save('resizedImage.mat', 'resizedImage'); 
save('labels.mat', 'labels');