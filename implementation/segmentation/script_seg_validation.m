clear;
dataDir = '../../dataset/Train/';
segDir = strcat(dataDir,'../trimmedTest/');

globalScores = zeros(1,11);
labelCount = 0;
% fileCount = 0;

dirContents = dir(dataDir);


%globalScores = zeros(size(dirContents,1),11);

parfor i = 3:size(dirContents,1)
    xmlFileName = dirContents(i).name;
    
    if ~all(xmlFileName(end-3:end) == '.xml')
        continue;
    end
    
%     fileCount = fileCount + 1;
%     
%     if mod(fileCount,60) == 0
%         disp(fileCount / 60);
%     end
    
    
    orgImg = imread([dataDir,xmlFileName(1:end-4),'.pgm']);
    
    fid = fopen([dataDir,xmlFileName]); %opens the file
    tline = fgets(fid); %gets the line
    while ischar(tline)
        labelCount = labelCount + 1;
        expression = '.*-x=(?<x>[-+]?\d+)-y=(?<y>[-+]?\d+)-w=(?<w>[-+]?\d+)-h=(?<h>[-+]?\d+).*';
        labelCords = regexp(tline,expression,'names');
                    
        lx = str2num(labelCords.x);
        ly = str2num(labelCords.y);
        lw = str2num(labelCords.w);
        lh = str2num(labelCords.h);
        
        localScores = zeros(1,11);

        %find all names of the segmented files
        dirSegContents = dir([segDir,xmlFileName(1:end-4)]);
        
        for j = 3:size(dirSegContents,1)
            segmentedFileName = dirSegContents(j).name;
            
            if ~all(segmentedFileName(end-3:end) == '.png')
                continue;
            end
            foundCords = regexp(segmentedFileName,expression,'names');
            
            fx = str2num(foundCords.x);
            fy = str2num(foundCords.y);
            fw = str2num(foundCords.w);
            fh = str2num(foundCords.h);
            
            if(fy < 0)
                
                fh = fh + fy;
                fy = 0;
                
            end
            
             labelRect = [lx,ly,lw,lh];
             foundRect = [fx,fy,fw,fh];
%             interArea = rectint(labelRect,foundRect); %intersection area
%             unionArea = (fw * fh) + (lw * lh) - interArea; %union area            
%             iou = interArea / unionArea;
            iou = seg_iou(labelRect,foundRect,orgImg);
            
            score = floor(iou * 10) + 1;
            
            for k = 1:score
                localScores(1,k) = 1;
            end
            
%             if(score > 1)
%                 close all;
%                 figure;
%                 hold on;
%                 imshow([dataDir,xmlFileName(1:end-4),'.pgm']);
%                 rectangle('Position',labelRect,'LineWidth',2,'EdgeColor','r');
%                 rectangle('Position',foundRect,'LineWidth',2,'EdgeColor','b');
%                 hold off;
%                 waitforbuttonpress;
%             end
            
        end
        tline = fgets(fid); %gets the next line
        globalScores = globalScores + localScores;
    end
    fclose(fid);

end

globalScores = globalScores(1,2:end);
globalScores = globalScores / labelCount;