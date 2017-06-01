function [ B ] = seg_binairy( A )

A = imgaussfilt(A,1);
[level, ~] = graythresh(A);
B = im2bw(A, level);

end

