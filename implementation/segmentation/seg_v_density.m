function [ cropped ] = seg_v_density( A ,debug)

threshold = floor(size(A,2) * 0.1);
addedWindowSize = 0.25;

A = imcomplement(A);
densities = sum(A,2);
densities = filter((1/10 * ones(1,10)),1,densities);
thDensities = densities;
thDensities(thDensities < threshold) = 0;
thDensities(thDensities >= threshold) = 1;

locSizes = seg_find_pixel_groups(thDensities');

[~,maxRow] = max(locSizes(:,2));


endLocation   =  locSizes(maxRow,1) + locSizes(maxRow,2) + (locSizes(maxRow,2) * addedWindowSize);
startLocation =  locSizes(maxRow,1) - (locSizes(maxRow,2) * addedWindowSize);
%[xmin ymin width height]
% maybe instead of taking a percentage take the closes minimum of the
% densities curve
cropped = imcrop(A,[0 startLocation size(A,2) abs(endLocation - startLocation)]);
cropped = imcomplement(cropped);

if debug
    figure;
    subplot(4,1,1);
    plot(1:size(densities,1),densities);
    title('Densities');

    subplot(4,1,2);
    plot(1:size(thDensities,1),thDensities);
    title('Thresholded densities');

    subplot(4,1,3);
    subimage(imcomplement(A));
    title('Full image');

    subplot(4,1,4);
    subimage(cropped);
    title('Cropped');
end


end

