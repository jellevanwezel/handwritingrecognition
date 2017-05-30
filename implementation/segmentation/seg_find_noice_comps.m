function [ noice, small ] = seg_find_noice_comps( small, framed )
%SEG_REMOVE_NOICE_COMPS Summary of this function goes here
%   Detailed explanation goes here

param_min_width = 15; %minimum width in pixels
param_max_percentage = 0.4; %max percentage black pixels in the frame 
noice = [];

for i = 1:length(small)
    smallComp = framed{small(i)};
    smallCompDims = size(smallComp);
    surface = smallCompDims(1) * smallCompDims(2);
    precentageBlack = sum(smallComp(:)) / surface;
    if precentageBlack > param_max_percentage || smallCompDims(2) < param_min_width
        noice = [noice,small(i)];
    end

end

small = setdiff(small,noice);

