clear;
dataDir = '/home/jelle/RUG/HR/dataset/Train/';
segDir = '/home/jelle/RUG/HR/dataset/Train_segmented_run_4t/';

fileCount = 0;

globalScores = zeros(1,11);
labelCount = 0;
% fileCount = 0;

labeledSet = {};

dirContents = dir(dataDir);

prevP = 0;
%globalScores = zeros(size(dirContents,1),11);

allFiles = 0;

for i = 3:size(dirContents,1)
    xmlFileName = dirContents(i).name;
    if all(xmlFileName(end-3:end) == '.xml')
        allFiles = allFiles + 1;
    end
    
end




for i = 3:size(dirContents,1)
    xmlFileName = dirContents(i).name;
    
    if ~all(xmlFileName(end-3:end) == '.xml')
        continue;
    end
    
    fileCount = fileCount + 1;
    
    if floor(fileCount / allFiles * 100) > prevP
        prevP = floor(fileCount / allFiles * 100);
        disp([num2str(prevP), '%']);
        
    end
    
    orgImg = imread([dataDir,xmlFileName(1:end-4),'.pgm']);
    
    fid = fopen([dataDir,xmlFileName]); %opens the file
    tline = fgets(fid); %gets the line
    while ischar(tline)
        labelCount = labelCount + 1;
        expression = '.*-x=(?<x>[-+]?\d+)-y=(?<y>[-+]?\d+)-w=(?<w>[-+]?\d+)-h=(?<h>[-+]?\d+).*<utf>\s(?<label>.*)\s<\/utf>.*';
        labelCords = regexp(tline,expression,'names');
        
        if isempty(fieldnames(labelCords)) || isempty(labelCords)
            tline = fgets(fid);
            continue;
        end
        lx = str2num(labelCords.x);
        ly = str2num(labelCords.y);
        lw = str2num(labelCords.w);
        lh = str2num(labelCords.h);
        label = labelCords.label;
        
        localScores = zeros(1,11);

        %find all names of the segmented files
        folderLineName = [segDir,xmlFileName(1:end-4),'/'];
        dirSegContents = dir(folderLineName);
        for j = 3:size(dirSegContents,1)
            segmentedFileName = dirSegContents(j).name;
            
            if ~all(segmentedFileName(end-3:end) == '.png')
                continue;
            end
            
            exp2 = '.*-x=(?<x>[-+]?\d+)-y=(?<y>[-+]?\d+)-w=(?<w>[-+]?\d+)-h=(?<h>[-+]?\d+).*';
            foundCords = regexp(segmentedFileName,exp2,'names');
                  
            if isempty(fieldnames(foundCords)) || isempty(foundCords)
                disp(segmentedFileName);
            end
            
            fx = str2num(foundCords.x);
            fy = str2num(foundCords.y);
            fw = str2num(foundCords.w);
            fh = str2num(foundCords.h);
            
            if fy < 0
                fh = fh + fy;
                fy = 0;
            end
            
            labelRect = [lx,ly,lw,lh];
            foundRect = [fx,fy,fw,fh];
            
             
            iou = seg_iou(labelRect,foundRect,orgImg);
            
            score = floor(iou * 10) + 1;
            
            for k = 1:score
                localScores(1,k) = 1;
            end
            
            if score >= 6
                labeledSet = [labeledSet;{{[folderLineName,segmentedFileName]},{label}}];
            end
            
        end
        tline = fgets(fid); %gets the next line
        globalScores = globalScores + localScores;
    end
    fclose(fid);

end

globalScores = globalScores(1,2:end);
globalScores = globalScores / labelCount;