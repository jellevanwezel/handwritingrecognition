function [ cords ] = seg_find_cords( comps, orgImage, croppedImage, cropped, angle, rotationPadding)

angle = -angle;

imgSize = size(orgImage);
croppedImageSize = size(croppedImage);

croppedTop = cropped(1);
croppedBottom = cropped(2);

trimmedLeft = cropped(4);
trimmedRight = cropped(3);

minRow = croppedTop;
maxRow = imgSize(1) - croppedBottom;

if sign(angle) == 1
  maxRow = maxRow - rotationPadding(1);
else
  minRow = minRow - rotationPadding(1);
end


cords = nan(size(comps,2),4);

for i = 1:size(comps,2)
    
    comp = comps{i};
    [~,minCol] = ind2sub(croppedImageSize,min(comp));
    [~,maxCol] = ind2sub(croppedImageSize,max(comp));
    
    %minCol = minCol - rotationPadding(2);
    %maxCol = maxCol + rotationPadding(2);
   
    minCol = minCol + trimmedLeft;
    maxCol = maxCol + trimmedLeft;
    
    [x1, y1] = seg_rotate_cords(minCol, minRow, angle);
    x2 = seg_rotate_cords(maxCol, minRow, angle);
    [~, y3] = seg_rotate_cords(minCol, maxRow, angle);
    
    %do all the things after the rotation, first rotation then trimming and
    %rotation padding after compensation for rotation
    
    cords(i,:) = [x1,y1, abs(x1-x2), abs(y1 - y3)];
    
end
