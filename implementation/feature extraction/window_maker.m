function [ Is ] = window_maker( I )

height = size(I,1);
width = size(I,2);
Is = cell(4,1);

halfWidth = ceil(width/2);
halfHeight = ceil(height/2);


Is{1,1} = I(1:halfHeight,1:halfWidth);
Is{2,1} = I(1:halfHeight,halfWidth+1:end);
Is{3,1} = I(halfHeight+1:end,1:halfWidth);
Is{4,1} = I(halfHeight+1:end,halfWidth+1:end);

for i = 1:length(Is)
    if isempty(Is{i})
        disp(size(I));
    end
end

end

