function [ comps ] = seg_merge_closest_neigbour( comps, small, I)

imageDims = size(I);

for i = 1:length(small)

    smallComp = comps{small(i)};
    
    [~,minCol] = ind2sub(imageDims,min(smallComp));
    [~,maxCol] = ind2sub(imageDims,max(smallComp));
    
    prevMaxCol = -inf;
    if small(i) ~= 1
        [~, prevMaxCol] = ind2sub(imageDims,max(comps{small(i) - 1})); 
    end
    nextMinCol = inf;
    if small(i) ~= length(comps)
        [~, nextMinCol] = ind2sub(imageDims,min(comps{small(i) + 1}));  
    end    
    
    [~,minIdx] = min([diff([prevMaxCol,minCol]),diff([maxCol,nextMinCol])]);
    
    if minIdx == 1
        comps{small(i) - 1} = [comps{small(i) - 1};smallComp];
    else
        comps{small(i) + 1} = [comps{small(i) + 1};smallComp];
    end
    
    comps{small(i)} = [];
    
end

comps = comps(~cellfun(@isempty, comps));

end

