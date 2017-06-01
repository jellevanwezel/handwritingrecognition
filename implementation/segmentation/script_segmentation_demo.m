% Segmentation Demo

meanWidth = 73.5944; % Mean width calculated from the labeled data
stdWidth = 8.4463; % std in width calculated from the labeled data

A = imread('../../dataset/Train/navis-Ming-Qing_18341_0004-line-001-y1=0-y2=289.pgm');
%A = imread('../../dataset/Train/navis-Ming-Qing_18637_0022-line-009-y1=1226-y2=1386.pgm');
binA = seg_binairy(A);

%[rotatedA,angle] = seg_rotation(binA);

% angle for the first image = 0.9
% calculating the angle takes a long time :/
rotatedA = imcomplement(imrotate(imcomplement(binA),0.9));

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
small = seg_small_whitespace(small ,characters, trimmedA, meanWidth, stdWidth);

%find noise components
noise = seg_find_noise_comps( small, framed );

nsb = [noise,small,big];

%removes the noise components
[characters, nsb] = seg_remove_noise_comps(characters, nsb); 

%merges small components to their best bet neighbors
[characters,nsb] = seg_merge_smallest_neigbour( characters, nsb, trimmedA, meanWidth, stdWidth);

%frames the components on a canvas
framed = seg_canvas_comps( characters , trimmedA);

%shows the components and the original image
seg_show_chars(A,framed,6,nsb); %6 is the amount of columns