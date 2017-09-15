function [ ratio ] = bw_ratio( I )
total = size(I,1) * size(I,2);
ratio = total / sum(sum(I(I==1)));
end

