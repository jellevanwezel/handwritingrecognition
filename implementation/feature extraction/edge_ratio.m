function [ ratio ] = edge_ratio( I ,method, direction)
c = filter_map(method,direction);
I = conv2(single(c),single(I));
ratio = bw_ratio(I);
end

