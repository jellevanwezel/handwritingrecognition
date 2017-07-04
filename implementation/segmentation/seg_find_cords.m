function [ cords ] = seg_find_cords( comps, orgImage, croppedImage, cropped, angle)

imgSize = size(orgImage);
croppedImageSize = size(croppedImage);
trimmedLeft = cropped(1);
trimmedRight = cropped(2);
croppedTop = cropped(3);
croppedBottom = cropped(4);

minRow = croppedTop;
maxRow = imgSize - croppedBottom;

for i = 1:size(comps,2)
    
    comp = comps{i};
    [~,minCol] = ind2sub(croppedImageSize,min(comp));
    [~,maxCol] = ind2sub(croppedImageSize,max(comp));    
    
    
end

% todo
% calc angles y'=y*cos(a) - x * sin(a); x'=y*sin(a) - x*cos(a);
% show segmentation to check
% run on labeled dataset

