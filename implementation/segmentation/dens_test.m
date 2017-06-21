% Before running, make sure your dataset is in ../../dataset/Train/
% Also make sure you have /implementation/segmentation as your working
% directory

clear;
dataDir = '../../dataset/Train_rotated/';
dirContents = dir(dataDir);

meanWidth = 73.5944; % Mean width calculated from the labeled data
stdWidth = 8.4463; % std in width calculated from the labeled data

    
    fileName = 'navis-Ming-Qing_18796_0013-line-005-y1=593-y2=759.pgm';
    
    %A = imread(strcat(dataDir,fileName));
    
    A = imread(strcat('../../dataset/Train/',fileName));
    [A,~] = seg_rotation(A);
    A = imrotate(A,0.2);
        
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
    A(rowMax-2 : rowMax + 2,:) = 0;
    
    minRows = [];
    
    for j = 2:size(dFiltered,2)
        if(dFiltered(j-1) <= 0 && dFiltered(j) >= 0) || (dFiltered(j) <= 0 && dFiltered(j-1) >= 0)
            minRows = [minRows,j];
        end
    end
    
    minLefts = fliplr(minRows(minRows < rowMax));
    minRights = minRows(minRows > rowMax);
    
    minLeft = 1;
    for j = 1:size(minLefts,2)
        minRow = minLefts(j);
        if filtered(1,minRow) < halfMax
            minLeft = minRow - 20 + 10; % sneaky 10
            break;
        end 
    end
    
    minRight = size(A,1);
    for j = 1:size(minRights,2)
        minRow = minRights(j);
        if filtered(1,minRow) < halfMax
            minRight = minRow - 20 - 10; % sneaky 10
            break;
        end 
    end
    
    if minRight - minLeft < 0
        minRight = size(A,1);
        minLeft = 1;
    end
    
    disp([minLeft,minRight,rowMax]);
    
    minima = [minLeft,minRight];
    B = A(minLeft:minRight,:);
    figure;
    imshow(B);
    figure;
    plot(1:size(A,1),diffRows);
    hold on;
    plot(1:size(A,1),dFiltered);
    for j = 1:size(minima,2);
        plot(minima(j) * ones(101,1),0:100);
    end
    hold off;
    waitforbuttonpress;
    close all;