% Segmentation Demo

meanWidth = 73.5944; % Mean width calculated from the labeled data
stdWidth = 8.4463; % std in width calculated from the labeled data

%A = imread('../../dataset/Train/navis-Ming-Qing_18341_0004-line-001-y1=0-y2=289.pgm');
A = imread('../../dataset/Train/navis-Ming-Qing_18637_0022-line-009-y1=1226-y2=1386.pgm');
binA = seg_binairy(A);

[rotatedA,angle] = seg_rotation(binA);

% angle for the first image = 0.9
% calculating the angle takes a long time :/
%rotatedA = imcomplement(imrotate(imcomplement(binA),0.9));

vCroppedA = seg_v_density(rotatedA,0);

trimmedA = seg_trim_image(vCroppedA);

characters = seg_concomp(trimmedA);

framed = seg_canvas_comps( characters , trimmedA);

[big,small] = seg_get_outliers(framed, meanWidth, stdWidth);

small = seg_small_whitespace(small ,characters, trimmedA, meanWidth);

noice = seg_find_noice_comps( small, framed );

%characters = seg_remove_noice_comps(noice,characters);  %when removing the noice the indexes of small change.. pls fix

small = setdiff(small,noice)

characters = seg_merge_closest_neigbour( characters, small, trimmedA);

%when 2 smalls get merged they get deleted... pls fix

framed = seg_canvas_comps( characters , trimmedA);

seg_show_chars(A,framed,6,meanWidth, stdWidth); %6 is the amount of columns