function [ small ] = seg_small_whitespace( small ,comps, I, m,std)
%SEG_SMALL_WHITESPACE Summary of this function goes here
%   Detailed explanation goes here

imageDims = size(I);

for i = 1:length(small)
    if ~small(i)
        continue
    end
    
    comp = comps{i};
    [~,minCol] = ind2sub(imageDims,min(comp));
    [~,maxCol] = ind2sub(imageDims,max(comp));
    prefMaxCol = -inf;
    %if this is the first char, the algorithm will take the right white space as indicator
    
    if i ~= 1
        [~, prefMaxCol] = ind2sub(imageDims,max(comps{i-1}));        
    end
    
    nextMinCol = inf;
    %If this is the last char, the algorithm will take the left white space as indicator
    
    if i ~= length(comps)
        [~, nextMinCol] = ind2sub(imageDims,min(comps{i+1}));        
    end
    
    whiteSpaceLeft = abs(minCol - prefMaxCol);
    whiteSpaceRight = abs(nextMinCol - maxCol);
    estematedCompSize = min([whiteSpaceLeft,whiteSpaceRight]) * 2 + abs(maxCol - minCol);
    
    if estematedCompSize >= m - 3 * std
           small(i) = 0;
    end
end



