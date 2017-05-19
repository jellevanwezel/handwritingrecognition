function [ B ] = seg_binairy( A )

A = imgaussfilt(A,1);
[level, EM] = graythresh(I)
B = im2bw(A, level);

end

