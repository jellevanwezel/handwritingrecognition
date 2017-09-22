clear;
dataDir = '/home/jelle/RUG/HR/dataset/Train/';

fileCount = 0;

globalScores = zeros(1,11);
labelCount = 0;
% fileCount = 0;

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

charSet = {};
labelSet = {};




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
        character = orgImg(ly:ly+lh,lx:lx+lw);
        
        charSet = [charSet,{character}];
        labelSet = [labelSet,{label}];
        
        tline = fgets(fid); %gets the next line
    end
    fclose(fid);

end