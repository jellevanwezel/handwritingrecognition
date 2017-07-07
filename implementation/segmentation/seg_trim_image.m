function [ B , trimmed] = seg_trim_image( A )

A = imcomplement(A);
startCol = 1;
endCol = size(A,2);

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
%B = imcrop(imcomplement(A),[startCol,0,abs(endCol- startCol),size(A,1)]);

trimmed = [startCol, size(A,2) - endCol];
B = A(1:size(A,1),startCol:endCol);
B = imcomplement(B);
