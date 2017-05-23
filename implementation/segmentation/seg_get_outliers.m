function [ big,small ] = seg_get_outliers( characters , meanLength, stdLength)


lengths = nan(length(characters),1);

for i = 1:length(characters)
    lengths(i) = size(characters{i},2);   
end

big = [];
small = [];

for i = 1:length(characters) 
    if lengths(i) <= meanLength - 2.5 * stdLength
        small = [small,i];
        continue;
    end
    if lengths(i) >= meanLength + 2.5 * stdLength
        big = [big,i];
    end
end

end

