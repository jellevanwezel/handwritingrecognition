function [ output_args ] = feature_extraction( labeledSigns )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    for i = 1:length(labeledSigns)
        [numPixelsX, numPixelsY] = size(labeledSigns{i})
        
        sign = bwmorph(labeledSigns{i},'skel',inf);

        sign=discourser(sign);
        
        
    end

end

