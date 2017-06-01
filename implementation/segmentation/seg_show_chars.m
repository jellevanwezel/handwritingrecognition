function [ ] = seg_show_chars( original, comps, cols ,nsb)

rows = ceil(length(comps)/cols) + 1;

figure;
subplot(rows,cols,1:cols);
subimage(original);
axis('off');
for i = 1:length(comps)
    subplot(rows,cols,i + cols);
    subimage(abs(comps{i} -1));
    titleString = num2str(i);
    if nsb(i,3)
        titleString = strcat(titleString,' (B)');
    end
    if nsb(i,2)
        titleString = strcat(titleString,' (S)');
    end
    title(titleString);
    axis('off');
end

end

