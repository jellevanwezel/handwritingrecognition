% Before running, make sure your dataset is in ../../dataset/Test/
% Also make sure you have /implementation/segmentation as your working
% directory

%Things still to do:
%  - Whitspace small should check for first char
%  - Check if too big chars are actualy multiple chars at the end. (maybe with the vertical density.)

dataDir = '../../dataset/Test/';
outputDir = strcat(dataDir,'../Test_segmented_100x100pix/');
mkdir(outputDir);
dirContents = dir(dataDir);

meanWidth = 73.5944; % Mean width calculated from the labeled data
stdWidth = 8.4463; % std in width calculated from the labeled data

for i = 3:size(dirContents,1)
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
    %vCroppedA = seg_v_density(rotatedA,0); %old version.
    vCroppedA = seg_v_density_2(rotatedA);
    
    %trims any whitespace from the sides
    trimmedA = seg_trim_image(vCroppedA);
    
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

    %frames the components on a canvas
    framed = seg_canvas_comps( newChars , trimmedA);    
    
    %------Write to file
    imageDir = strcat(outputDir,fileName(1:end-4),'/');
    mkdir(imageDir);
    disp(fileName(1:end-4));
    for j = 1:length(framed)
        I = abs(framed{j}-1);
        % Already resizes the image to 100x100 pixels
        I = imresize(I, [100 100]);
        imwrite(I,strcat(imageDir,num2str(j),'.png'));
    end
    disp(strcat('finished - ', fileName(1:end-4)));
end