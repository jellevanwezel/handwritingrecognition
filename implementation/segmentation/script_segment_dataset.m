% Before running, make sure your dataset is in ../../dataset/Train/
% Also make sure you have /implementation/segmentation as your working
% directory

%Things still to do:
%  - Whitspace small should check for first char
%  - Check if too big chars are actualy multiple chars at the end. (maybe with the vertical density.)

clear;
runNumber = 4;
runName = ['Train_segmented_run_',num2str(runNumber)];
dataDir = '../../dataset/Train/';
outputDir = strcat(dataDir,'../',runName,'/');
mkdir(outputDir);
dirContents = dir(dataDir);

meanWidth = 73.5944; % Mean width calculated from the labeled data
stdWidth = 8.4463; % std in width calculated from the labeled data

for i = 3:10%size(dirContents,1)
    fileName = dirContents(i).name;
    
    if ~all(fileName(end-3:end) == '.pgm')
        continue;
    end
    
    A = imread(strcat(dataDir,fileName));
    
    %------Magic happens here:
    
    %binarize image
    binA = seg_binairy(A);
    
    %rotate image
    [rotatedA,angle] = seg_rotation(binA);
    
    %get the amount padded by the rotation
    rotationPadding = size(rotatedA) - size(A);

    %crops the image verticaly 
    %vCroppedA = seg_v_density(rotatedA,0); %old version.
    [vCroppedA, vCropped] = seg_v_density_2(rotatedA);
    
    %trims any whitespace from the sides
    [trimmedA, hCropped] = seg_trim_image(vCroppedA); %todo get the amount trimmed
    
    %gets the connected components
    characters = seg_concomp(trimmedA);
    
    %frames the components on a canvas
    framed = seg_canvas_comps( characters , trimmedA);
    
    %finds the outliers: 3 std +/- the mean from the labeled data
    [big,small] = seg_find_outliers(framed, meanWidth, stdWidth);

    %checks if this 'small' char is a standalone char
    small = seg_small_whitespace(small ,characters, trimmedA, meanWidth, stdWidth);
    
    %find noise components
    noise = seg_find_noise_comps( small, framed );

    nsb = [noise,small,big];

    %removes the noise components
    [characters, nsb] = seg_remove_noise_comps(characters, nsb); 
    
    %merges small components to their best bet neighbors
    [characters,nsb] = seg_merge_smallest_neigbour( characters, nsb, trimmedA, meanWidth, stdWidth);
    
    newChars = cell(0);
    for j = 1:size(characters,2)
        if nsb(j,3) == 0
            newChars = {newChars{:},characters{j}};
            continue;
        end
        splitted = seg_split_big(characters{j}, meanWidth, stdWidth, 10);
        newChars = {newChars{:},splitted{:}};      
    end
    
    %get the cordinates of the chars in the original image
    cords = seg_find_cords( newChars, A, trimmedA, [vCropped,hCropped], angle, rotationPadding);

    %frames the components on a canvas
    framed = seg_canvas_comps( newChars , trimmedA);    
    
    %------Write to file
    imageDir = strcat(outputDir,fileName(1:end-4),'/');
    mkdir(imageDir);
    disp(fileName(1:end-4));
    for j = 1:length(framed)
        I = abs(framed{j}-1);
        cord = cords(j,:);
        imgCordName = strcat(num2str(j),'-x=',num2str(cord(1)),'-y=',num2str(cord(2)),'-w=',num2str(cord(3)),'-h=',num2str(cord(4)));
        imwrite(I,strcat(imageDir,imgCordName,'.png'));
    end
    disp(strcat('finished - ', fileName(1:end-4)));
end

disp('Segmentation Done');
disp('Zipping...');
zip([dataDir,'../',runName,'.zip'],outputDir);
disp('Zipping Done');