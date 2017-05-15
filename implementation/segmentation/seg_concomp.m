function [ CC ] = seg_concomp( A )
    se = strel('disk',3);
    
    closed = imclose(A,se);
    CC = bwconncomp(closed);

    for i=1:length(CC.PixelIdxList)
        pixels = CC.PixelIdxList{i};
        minCol = inf;
        maxCol = -inf;
        for j = 1 : size(pixels,1)
            pIdx = pixels(j,1);
            col = mod(pIdx -1, size(A,2)) + 1;
            if col < minCol
                minCol = col;
            end
            if col > maxCol
                maxCol = col;
            end
        end
        imshow(A(:,minCol:maxCol));
        break;
    end
    
end

