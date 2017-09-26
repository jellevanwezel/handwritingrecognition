function [ labelMap ] = labelMapper( labels )

labelMap = struct();

labelCount = 1;

for i = 1:length(labels)
    
    label = labels{i};
    if iscell(label)
        label = label{1};
    end
    
    if(isfield(labelMap,['l',label]))
        continue;
    end
    
    labelMap = setfield(labelMap,['l',label],labelCount);
    labelCount = labelCount + 1;

end

