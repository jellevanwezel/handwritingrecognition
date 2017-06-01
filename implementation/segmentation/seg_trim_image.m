function [ B ] = seg_trim_image( A )

A = imcomplement(A);
startCol = 0;
endCol = 0;

for i = 1:size(A,2)
    if sum(A(:,i)) ~= 0
        startCol = i;
        break;
    end
end

for i = fliplr(1:size(A,2))
    if sum(A(:,i)) ~= 0
        endCol = i;
        break;
    end
end

%[xmin ymin width height]
B = imcrop(imcomplement(A),[startCol,0,abs(endCol- startCol),size(A,1)]);
