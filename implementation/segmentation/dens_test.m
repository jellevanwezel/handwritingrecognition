% Before running, make sure your dataset is in ../../dataset/Train/
% Also make sure you have /implementation/segmentation as your working
% directory

clear;
dataDir = '../../dataset/Train_rotated/';
dirContents = dir(dataDir);

meanWidth = 73.5944; % Mean width calculated from the labeled data
stdWidth = 8.4463; % std in width calculated from the labeled data

for i = 3:50%size(dirContents,1)
    fileName = dirContents(i).name;
    
    if ~all(fileName(end-3:end) == '.png')
        continue;
    end
    
    A = imread(strcat(dataDir,fileName));
    
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
    
    
    %minima = find(dFiltered == 0);
    %minima = minima + 3;
    
    figure;
    imshow(A);
    figure;
    plot(1:size(A,1),filtered);
    hold on;
    plot(1:size(A,1),dFiltered);
    for j = 1:size(minima,2);
        plot(minima(j) * ones(101,1),0:100);
    end
    hold off;
    waitforbuttonpress;
    close all;
end