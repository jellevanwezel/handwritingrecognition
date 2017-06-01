function [ noise, small ] = seg_find_noise_comps( small, framed )
%SEG_REMOVE_NOICE_COMPS Summary of this function goes here
%   Detailed explanation goes here

param_min_width = 15; %minimum width in pixels
param_max_percentage = 0.4; %max percentage black pixels in the frame 
noise = zeros(length(small),1);

for i = 1:length(small)
    if ~small(i)
        continue;
    end
    smallComp = framed{i};
    smallCompDims = size(smallComp);
    surface = smallCompDims(1) * smallCompDims(2);
    precentageBlack = sum(smallComp(:)) / surface;
    if precentageBlack > param_max_percentage || smallCompDims(2) < param_min_width
        noise(i) = 1;
    end
end

