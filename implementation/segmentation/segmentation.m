% Segmentation Demo

%A = imread('../../dataset/Train/navis-Ming-Qing_18341_0004-line-001-y1=0-y2=289.pgm');
A = imread('../../dataset/Train/navis-Ming-Qing_18637_0022-line-009-y1=1226-y2=1386.pgm');
binA = seg_binairy(A);

[rotatedA,angle] = seg_rotation(binA);
% angle for this image = 0.9
% calculating the angle takes a long time :/
%rotatedA = imcomplement(imrotate(imcomplement(binA),0.9));

vCroppedA = seg_v_density(rotatedA,0);

trimmedA = seg_trim_image(vCroppedA);

%seg_h_density( trimmedA, 1 )

merged = seg_concomp(trimmedA);

[big,small] = seg_get_outliers(merged)

%imshow(trimmedA);