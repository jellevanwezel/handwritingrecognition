function [ A ] = seg_v_density_2( A )
   
    diffRows = zeros(1,size(A,1));
    for j = 1:size(A,1);
        rowDiff = diff(A(j,:));
        rowDiff(rowDiff<1) = 0;
        diffRows(j) = sum(rowDiff,2);
    end
    
    filtered = filter(1/20 * ones(20,1),1,diffRows);
    dFiltered = filter([-1,0,1],1,filtered);
    
    [maxValue, rowMax] = max(filtered);
    halfMax = 1/2 * maxValue;    
    minRows = [];
    
    for j = 2:size(dFiltered,2)
        if(dFiltered(j-1) <= 0 && dFiltered(j) >= 0) || (dFiltered(j) <= 0 && dFiltered(j-1) >= 0)
            minRows = [minRows,j];
        end
    end
   
    
    minLefts = fliplr(minRows(minRows < rowMax));
    minRights = minRows(minRows > rowMax);
    
    
    
    minLeft = 1;
    for i = 1:size(minLefts,2)
        minRow = minLefts(i);
        if filtered(1,minRow) < halfMax
            minLeft = minRow - 20 + 10; % sneaky 10
            if minLeft < 1
                minLeft = 1;
            end
            break;
        end 
    end
    
    minRight = size(A,1);
    for i = 1:size(minRights,2)
        minRow = minRights(i);
        if filtered(1,minRow) < halfMax
            minRight = minRow - 20 - 10; % sneaky 10
            if minRight < 1
                minRight = size(A,1);
            end
            break;
        end 
    end
    
    if minRight - minLeft < 0
        minRight = size(A,1);
        minLeft = 1;
    end
    A = A(minLeft:minRight,:);
end

