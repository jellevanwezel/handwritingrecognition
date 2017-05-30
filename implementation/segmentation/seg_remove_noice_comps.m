function [ comps ] = seg_remove_noice_comps( noice, comps )

for i = 1:length(noice)
    compIdx = noice(i);
    comps{compIdx} = [];
end

comps = comps(~cellfun(@isempty, comps));

end

