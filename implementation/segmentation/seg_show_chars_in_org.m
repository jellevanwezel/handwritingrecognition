function [ ] = seg_show_chars_in_org( I, cords )

imshow(I);
hold on;
for i = 1 : size(cords,1)
    cord = cords(i,:);
    rectangle('Position',cord,'EdgeColor','r');     
end
hold off;

end

