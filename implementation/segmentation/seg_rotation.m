function [ B , optimalAngle] = seg_rotation(A)

% Resizes the image in the vertical direction by 1/3
% Then rotates it between 2 and -2 degrees
% Finds the 'best' rotation

A = imcomplement(A);
maxDensity = -inf;
optimalAngle = 0;

for angle = -1:0.1:1
    rotImage = imrotate(A,angle);
    rotImage = imresize(rotImage,[floor(size(rotImage,1)/3), size(rotImage,2)]);
    if(max(sum(rotImage,2)) > maxDensity)
        maxDensity = max(sum(rotImage,2));
        optimalAngle = angle;
    end
end
B = imcomplement(imrotate(A,optimalAngle));
end

