function [ big,small ] = seg_find_outliers( characters , meanLength, stdLength)


lengths = nan(length(characters),1);

for i = 1:length(characters)
    lengths(i) = size(characters{i},2);   
end

big = zeros(length(characters),1);
small = zeros(length(characters),1);

for i = 1:length(characters) 
    if lengths(i) <= meanLength - 2.5 * stdLength %magic number pls fix
        small(i) = 1;
        continue;
    end
    if lengths(i) >= meanLength + 2.5 * stdLength
        big(i) = 1;
    end
end

end

