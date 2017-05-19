function [ ] = seg_show_chars( original, comps, cols )

rows = ceil(length(comps)/cols) + 1;

[big,small] = seg_get_outliers(comps);

figure;
subplot(rows,cols,1:cols);
subimage(original);
axis('off');
for i = 1:length(comps)
    subplot(rows,cols,i + cols);
    subimage(abs(comps{i} -1));
    titleString = num2str(i);
    if ismember(i,big)
        titleString = strcat(titleString,' (B)');
    end
    if ismember(i,small)
        titleString = strcat(titleString,' (S)');
    end
    title(titleString);
    axis('off');
end

end

