function [ framedComps ] = seg_merge_groups( components, imageDims)

overlap_threshold = 0.15;
%the percentage of overlap between components for them to be merged

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
framedComps = cell(1,length(components));
%allImages = [ones(imageDims(1),3),zeros(imageDims(1),3)];
for i = 1:length(components)
    canvas = zeros(imageDims);
    canvas(components{i}) = 1;
    while(sum(canvas(:,1)) == 0)
        canvas(:,1) = [];
    end
    while(sum(canvas(:,end)) == 0)
        canvas(:,end) = [];
    end
    %allImages = [allImages,canvas,zeros(imageDims(1),3),ones(imageDims(1),3)];
    framedComps{i} = canvas;
end

%imshow(abs(allImages - 1));

end

