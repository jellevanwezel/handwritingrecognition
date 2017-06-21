function [ A ] = seg_v_density_2( A, meanWidth, stdWidth )
   
    diffRows = zeros(1,size(A,1));
    for j = 1:size(A,1);
        rowDiff = diff(A(j,:));
        rowDiff(rowDiff<1) = 0;
        diffRows(j) = sum(rowDiff,2);
    end
    [~, rowMax] = max(diffRows);
    A(rowMax-2 : rowMax + 2,:) = 0;
    
    filtered = filter(1/20 * ones(20,1),1,diffRows);
    dFiltered = filter([-1,0,1],1,filtered);
    
    minima = [];
    
    for j = 2:size(dFiltered,2)
        if(dFiltered(j-1) <= 0 && dFiltered(j) >= 0) || (dFiltered(j) <= 0 && dFiltered(j-1) >= 0)
            minima = [minima,j];
        end
    end
    
    %Find the closest minima where the filtered is close to 1/2 the max in both directions.
    
    
    
end

