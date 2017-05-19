function [ framedComps ] = seg_merge_groups( components, A)

overlap_threshold = 0.15;
%the percentage of overlap between components for them to be merged

imageDims = size(A);

for i = 1:length(components)
    if isempty(components{i})
        continue;
    end
    pixelInds = components{i};
    [~,minCol] = ind2sub(imageDims,min(pixelInds));
    [~,maxCol] = ind2sub(imageDims,max(pixelInds));
    width1 = abs(minCol - maxCol);
    for j = 1:length(components)
        if i == j || isempty(components{j})
            continue;
        end
        
        pixelInds2 = components{j};
        [~,minCol2] = ind2sub(imageDims,min(pixelInds2));
        [~,maxCol2] = ind2sub(imageDims,max(pixelInds2));
        width2 = abs(minCol2 - maxCol2);
        
        if minCol2 > maxCol || maxCol2 < minCol 
            %These components are not overlapping
            continue;
        end
        overlap = abs((abs(minCol - minCol2) + abs(maxCol - maxCol2)) - width1);
        if 1 - (overlap / width2) >= overlap_threshold
            components{i} = [components{i};components{j}];
            components{j} = [];
        end
        
    end
    
end
components = components(~cellfun(@isempty, components));
framedComps = seg_canvas_comps( components , A);

end

