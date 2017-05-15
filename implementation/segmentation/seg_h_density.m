function [ Bs ] = seg_h_density( A ,debug)


threshold = 12;
%addedWindowSize = 0.25;

A = imcomplement(A);
densities = sum(A,1);
fDensities = filter((1/25 * ones(1,25)),1,densities);
thDensities = fDensities;
thDensities(thDensities < threshold) = 0;
thDensities(thDensities >= threshold) = 1;

minima = [];

direction = 0;
for i = 2:size(fDensities,2)
    prev = fDensities(1,i-1);
    cur = fDensities(1,i);    
    if prev > cur
        direction = -1;
    end   
    if prev < cur     
        if direction == -1
            minima = [minima;[i-1,prev]];
        end      
        direction = 1;
    end
end

%locSizes = seg_find_pixel_groups(thDensities);

if debug
    
    figure;
    subplot(4,1,1);
    plot(1:size(densities,2),densities);
    title('Densities');
    xlim([1 size(densities,2)]);
    
    subplot(4,1,2);
    plot(1:size(fDensities,2),fDensities);
    
    hold on;
    for i = 1:size(minima,1)
        if minima(i,2) <= threshold
            plot(minima(i,1) * ones(floor(max(fDensities)),1),1:max(fDensities),'Color','Red');
            %A(:,minima(i,1) - 12 - 1 : minima(i,1) - 12 + 1) = 1;
        end
    end
    hold off;
    
    title('Densities');
    xlim([1 size(fDensities,2)]);

    subplot(4,1,3);
    se = strel('disk',3);
    
    closed = imcomplement(imclose(A,se));
    
    subimage(closed);
    title('Closed image');   
    
    subplot(4,1,4);
    
    subimage(imcomplement(A));
    title('Original image');
    
    CC = bwconncomp(closed);
    
    

end



end

