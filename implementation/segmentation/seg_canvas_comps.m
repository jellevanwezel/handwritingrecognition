function [ framedComps ] = seg_canvas_comps( components , A)

framedComps = cell(1,length(components));
for i = 1:length(components)
    canvas = zeros(size(A));
    canvas(components{i}) = 1;
    canvas = canvas & abs(A - 1);    
    while(sum(canvas(:,1)) == 0)
        canvas(:,1) = [];
    end
    while(sum(canvas(:,end)) == 0)
        canvas(:,end) = [];
    end
    framedComps{i} = canvas;
end

end

