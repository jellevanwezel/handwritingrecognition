function [ B , optimalAngle] = seg_rotation(A)

A = im2bw(A, 0.4);
A = imcomplement(A);
maxDensity = -inf;
optimalAngle = 0;
C = imresize(A,[floor(size(A,1)/3), size(A,2)]);

for angle= -3:0.1:3
    rotImage = imrotate(C,angle);
    densities = sum(rotImage,1);
    if(max(sum(rotImage,2)) > maxDensity)
        maxDensity = max(sum(rotImage,2));
        optimalAngle = angle;
    end
end
B = imcomplement(imrotate(A,optimalAngle));
end

