function [ locationSize ] = seg_find_pixel_groups( binVect )

cumSum = cumsum([binVect 0]);
pixelGroups = diff( [0 cumSum(diff([binVect 0]) == -1) ] );
locationSize = nan(size(pixelGroups,2),2);

inGroup = 0;
groupNumber = 0;

for i = 1:size(binVect,2)
   
    if binVect(1,i) == 1
        if inGroup == 0
            inGroup = 1;
            groupNumber = groupNumber + 1;
            locationSize(groupNumber,1) = i;
            locationSize(groupNumber,2) = 0;
        end
        locationSize(groupNumber,2) = locationSize(groupNumber,2) + 1;      
    else
        inGroup = 0; 
    end

end

