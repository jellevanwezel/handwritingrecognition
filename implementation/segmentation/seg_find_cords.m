function [ cords ] = seg_find_cords( comps, rotatedImage, croppedImage, cropped, angle, rotationPadding)

angle = -angle;

rotImgSize = size(rotatedImage);
croppedImageSize = size(croppedImage);

croppedTop = cropped(1);
croppedBottom = cropped(2);

trimmedLeft = cropped(3);
trimmedRight = cropped(4);


minRow = croppedTop;
%the min row of the rotated image
maxRow = croppedTop + croppedImageSize(1);

%the max row of the rotated image

cords = nan(size(comps,2),4);

for i = 1:size(comps,2)
    
    comp = comps{i};
    [~,minCol] = ind2sub(croppedImageSize,min(comp));
    [~,maxCol] = ind2sub(croppedImageSize,max(comp));
   
    minCol = minCol + trimmedLeft;
    maxCol = maxCol + trimmedLeft;
    
    %the min col of this component in the rotated image.
    
    cPoints = nan(4,2);
    
    [cPoints(1,1), cPoints(1,2)] = seg_rotate_cords(minCol, minRow, angle);
    [cPoints(2,1), cPoints(2,2)] = seg_rotate_cords(maxCol, minRow, angle);
    [cPoints(3,1), cPoints(3,2)] = seg_rotate_cords(maxCol, maxRow, angle);
    [cPoints(4,1), cPoints(4,2)] = seg_rotate_cords(minCol, maxRow, angle);
    
    x = min(cPoints(:,1));
    y = min(cPoints(:,2)); 
    w = round(abs(min(cPoints(:,1)) - max(cPoints(:,1))));
    h = round(abs(max([cPoints(1,2), cPoints(1,2)]) - min([cPoints(3,2),cPoints(4,2)])));
    
    x = round(x - (rotationPadding(2)));
    y = round(y - (rotationPadding(1)));
    
    %Compensate for the rotation padding 
    
    cords(i,:) = [x,y,w,h];
    
end
