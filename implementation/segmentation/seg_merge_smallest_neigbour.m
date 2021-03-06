function [ comps,nsb ] = seg_merge_smallest_neigbour( comps, nsb, I,meanWidth, stdWidth)

% Function merges small components into their neighbors
% It tries to make a "best" average fit
% If both neighbours are BIG it doesnt merge
% Merge with the smalles neighbour


imageDims = size(I);

wse = nan(length(comps),3); %Width,Start,End

for i = 1:length(comps)
    comp = comps{i};
    [~,minCol] = ind2sub(imageDims,min(comp));
    [~,maxCol] = ind2sub(imageDims,max(comp));
    compSize = abs(minCol - maxCol);
    wse(i,:) = [compSize,minCol,maxCol];
end


i = 0;
while i < length(comps);
    i = i + 1;

    %check the size of the componentsVector and if the component is small 
    if length(comps) <= 1 || ~nsb(i,2)
        continue;
    end

    smallComp = comps{i};
    
    %check if this is the firs component and if the next one is big
    if i == 1 && nsb(2,3) == 1
        continue;
    end
    
    %check if this is the last component and the previous one is big
    if i == length(comps) && nsb(end-1,3) == 1
        continue;
    end
    
    %check if this component is inbetween 2 big components
    if (i~= 1 && i ~= length(comps)) && (nsb(i-1,3) && nsb(i+1,3))
        continue;
    end
    
    mergeDirection = 0;
    
    if i == 1 || i == length(comps)
        if i == 1
            mergeDirection = 1;
        else
            mergeDirection = -1;
        end
    else
        newWidthLeft = abs(wse(i - 1, 2) - wse(i,3));
        newWidthRight = abs(wse(i + 1, 3) - wse(i,2));
        
        if  newWidthLeft < newWidthRight
            %merge left
            mergeDirection = -1;     
        else
            %merge right
            mergeDirection = 1;
        end
        
    end
    
    
    newComp = [comps{i + mergeDirection};smallComp];
    
    [~,minCol] = ind2sub(imageDims,min(newComp));
    [~,maxCol] = ind2sub(imageDims,max(newComp));
    compSize = abs(minCol - maxCol);
    
    if compSize >= 2 * meanWidth
        %new comp looks too big, leave this small comp alone
        continue;
    end
    
    comps{i + mergeDirection} = newComp;
    wse(i + mergeDirection,:) = [compSize,minCol,maxCol];
    
    newCompIsSmall = 0;
    
    if wse(i + mergeDirection,1) <= meanWidth - 3 * stdWidth
        nsb(i + mergeDirection,:) = [0,1,0];
        newCompIsSmall = 1;
    end
    if wse(i + mergeDirection,1) > meanWidth + 3 * stdWidth
        nsb(i + mergeDirection,:) = [0,0,1];
    end
    
    comps{i} = [];
    comps = comps(~cellfun(@isempty, comps));   
    nsb(i,:) = [];
    wse(i,:) = [];
    
    if newCompIsSmall && mergeDirection == -1
        i = i-2;
    else
        i = i-1;
    end
    
    
end

end

