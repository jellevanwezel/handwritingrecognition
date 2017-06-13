function [ splitted ] = seg_split_big(I, meanWidth, stdWidth, avgFilter)
     

    % Todo: find the white spaces in this image, less variations should have
    % a higher split priority
    
    %Search for pixelgroups

    diffColls = zeros(1,size(I,2));
    for i = 1:size(I,2);
        colDiff = diff(I(:,i));
        colDiff(colDiff<1) = 0;
        diffColls(i) = sum(colDiff);
    end
    binDiffs = filter(1/avgFilter * ones(1,avgFilter),1, diffColls);
    binDiffs(binDiffs <= 1) = 0;
    binDiffs(binDiffs > 1) = 1;
    startCol = floor(meanWidth - 3 * stdWidth);
    endCol =  size(I,2) - floor(meanWidth - 1 * stdWidth);
    
    %Check if there is atleast one group if not return the old image
    if sum(binDiffs(startCol:endCol)) == 0
        splitted = cell(1);
        splitted{1} = I;
        return;
    end
    
    %Find pixelgroups, locations and width
    whiteSpaceRegions = [];
    inGroup = 0;
    for i = startCol:endCol
        
        if binDiffs(i) == 1 && inGroup == 0
            inGroup = 1;
            whiteSpaceRegions(end+1,:) = [i,endCol, abs(i-endCol)]; 
        end
        
        if binDiffs(i) == 0 && inGroup == 1
            inGroup = 0;
            whiteSpaceRegions(end,2) = i;
            whiteSpaceRegions(end,3) = abs(whiteSpaceRegions(end,1) - i);
        end
    end
    
    %Get biggest whitespace location
    sWSR = sortrows(whiteSpaceRegions,3);
    splitLoc = sWSR(1,1) + round(0.5 * sWSR(1,3)) + avgFilter;
    
    %Split the image and return the 2 splits.
    A = I(:,1:splitLoc);
    B = I(:,splitLoc:end);
    
    splitted = cell(0);
        
    if size(A,2) > meanWidth + 3 * stdWidth
        splittedR = seg_split_big(A,meanWidth,stdWidth,10);
        if length(splittedR) > 1
            splitted = {splitted{:},splittedR{:}};
        end
    else
        A = seg_trim_image(A);
        splitted = {splitted{:},A};
    end
    
    if size(B,2) > meanWidth + 3 * stdWidth
        splittedR = seg_split_big(B,meanWidth,stdWidth,10);
        if length(splittedR) > 1
            splitted = {splitted{:},splittedR{:}};
        end
    else
        B = seg_trim_image(B);
        splitted = {splitted{:},B};
    end
end

