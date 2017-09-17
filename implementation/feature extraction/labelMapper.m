function [ labelMap ] = labelMapper( labels )

labelMap = struct();

labelCount = 1;

for i = 1:length(labels)
    
    labelCell = labels{i};
    label = labelCell{1};
    
    if(isfield(labelMap,['l',label]))
        continue;
    end
    
    labelMap = setfield(labelMap,['l',label],labelCount);
    labelCount = labelCount + 1;

end

