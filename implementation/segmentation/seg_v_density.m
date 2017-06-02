function [ cropped ] = seg_v_density( A )

threshold = floor(size(A,2) * 0.1);
addedWindowSize = 0.25;

A = imcomplement(A);
densities = sum(A,2);
densities = filter((1/10 * ones(1,10)),1,densities);
thDensities = densities;
thDensities(thDensities < threshold) = 0;
thDensities(thDensities >= threshold) = 1;

locSizes = seg_find_pixel_groups(thDensities');

if isempty(locSizes)
    cropped = imcomplement(A);
    return;
end

[~,maxRow] = max(locSizes(:,2));


endLocation   =  locSizes(maxRow,1) + locSizes(maxRow,2) + (locSizes(maxRow,2) * addedWindowSize);
startLocation =  locSizes(maxRow,1) - (locSizes(maxRow,2) * addedWindowSize);
%[xmin ymin width height]
% maybe instead of taking a percentage take the closest minimum of the
% densities curve
% cropped = imcrop(A,[0 startLocation size(A,2) abs(endLocation - startLocation)]);

%imcrop tried to open a window or smthing, so I made my own cropper:

cropped= A(round(startLocation):round(startLocation+abs(endLocation - startLocation)),1:end);
cropped = imcomplement(cropped);

end

