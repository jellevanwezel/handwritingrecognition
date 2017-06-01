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

    %crops the image verticaly
    vCroppedA = seg_v_density(rotatedA,0);

    %trims any whitespace from the sides
    trimmedA = seg_trim_image(vCroppedA);

    %gets the connected components
    characters = seg_concomp(trimmedA);

    %frames the components on a canvas
    framed = seg_canvas_comps( characters , trimmedA);

    %finds the outliers: 2.5 std +/- the mean from the labeled data
    [big,small] = seg_find_outliers(framed, meanWidth, stdWidth);

    %checks if this 'small' char is a standalone char
    small = seg_small_whitespace(small ,characters, trimmedA, meanWidth);

    %find noise components
    noise = seg_find_noise_comps( small, framed );

    nsb = [noise,small,big];

    %removes the noise components
    [characters, nsb] = seg_remove_noise_comps(characters, nsb); 

    %merges small components to their best bet neighbors
    [characters,nsb] = seg_merge_smallest_neigbour( characters, nsb, trimmedA, meanWidth, stdWidth);

    %frames the components on a canvas
    framed = seg_canvas_comps( characters , trimmedA);    
    
    %------Write to file
    imageDir = strcat(outputDir,fileName(1:end-4),'/');
    mkdir(imageDir);
    for j = 1:length(framed)
        I = abs(framed{j}-1);
        imwrite(I,strcat(imageDir,num2str(j),'.png'));
    end
end