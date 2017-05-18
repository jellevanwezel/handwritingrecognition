function [ B ] = seg_binairy( A )

A = medfilt2(A);
A = imgaussfilt(A,1);
B = im2bw(A, 0.4);

end

