function [ labels ] = label_to_number( labelAsStrings, labelMap )

labels = nan(length(labelAsStrings),1);

for i = 1:length(labelAsStrings)
    labelCell = labelAsStrings{i};
    label = labelCell{1};
    labelNumber = getfield(labelMap,['l',label]);
    labels(i,1) = labelNumber;
end

