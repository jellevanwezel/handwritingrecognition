function [ s ] = filter_map(method, direction)
% method: prewit, sobel
% direction: h,v,dl,dr 

fh = str2func([method,'_',direction]);
s = fh();
end

