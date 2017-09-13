function [ ratio ] = bw_ratio( I )
invI = abs(I - 1);
ratio = sum(sum(I(I==1))) / sum(sum(invI(invI==1)));
end

