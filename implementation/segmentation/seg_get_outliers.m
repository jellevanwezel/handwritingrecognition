function [ big,small ] = seg_get_outliers( characters )


lengths = nan(length(characters),1);

for i = 1:length(characters)
    lengths(i) = size(characters{i},2);   
end

meanLength = mean(lengths)
stdLength = std(lengths,1)

big = [];
small = [];

for i = 1:length(characters) 
    if lengths(i) <= meanLength - stdLength
        small = [small,i];
        continue;
    end
    if lengths(i) >= meanLength + 2 * stdLength
        big = [big,i];
    end
end

end

