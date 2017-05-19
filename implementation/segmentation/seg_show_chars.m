function [ ] = seg_show_chars( original, comps, cols )

rows = ceil(length(comps)/cols) + 1;

figure;
subplot(rows,cols,1:cols);
subimage(original);
axis('off');
for i = 1:length(comps)
    subplot(rows,cols,i + cols);
    subimage(abs(comps{i} -1));
    title(num2str(i));
    axis('off');
end

end

