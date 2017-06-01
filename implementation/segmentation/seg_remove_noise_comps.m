function [ comps, nsb ] = seg_remove_noise_comps(comps, nsb )

for i = 1:length(comps)
    if ~nsb(i,1)
        continue;
    end
    comps{i} = [];
    nsb(i,:) = -1;
end

comps = comps(~cellfun('isempty',comps));
nsb(nsb(:,1) == -1,:) = [];

end

