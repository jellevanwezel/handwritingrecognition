function [ small ] = seg_small_whitespace( small ,comps, I, m)
%SEG_SMALL_WHITESPACE Summary of this function goes here
%   Detailed explanation goes here

imageDims = size(I);

for i = 1:length(small)
    compIdx = small(i);
    comp = comps{compIdx};
    [~,minCol] = ind2sub(imageDims,min(comp));
    [~,maxCol] = ind2sub(imageDims,max(comp));
    prefMaxCol = 1;
    if compIdx ~= 1
        [~, prefMaxCol] = ind2sub(imageDims,max(comps{compIdx-1}));        
    end
    nextMinCol = imageDims(2);
    if compIdx ~= length(comps)
        [~, nextMinCol] = ind2sub(imageDims,min(comps{compIdx+1}));        
    end
    whiteSpaceLeft = minCol - prefMaxCol;
    whiteSpaceRight = nextMinCol - maxCol;
    
    estematedCompSize = min([whiteSpaceLeft,whiteSpaceRight]) * 2 + (maxCol - minCol);
       
    if estematedCompSize >= m
           small(i) = nan;
    end
end
small(isnan(small)) = [];



