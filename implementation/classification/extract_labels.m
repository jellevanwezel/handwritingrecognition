
clear;
dataDir = '/home/jelle/RUG/HR/dataset/Train/';
dirContents = dir(dataDir);

labels = [];

prevP = 0;
allFiles = size(dirContents,1);

for i = 3:allFiles
    
    xmlFileName = dirContents(i).name;
    
    if ~all(xmlFileName(end-3:end) == '.xml')
        continue;
    end
    
    if floor(i / allFiles * 100) > prevP
        prevP = floor(i / allFiles * 100);
        disp([num2str(prevP), '%']);
    end
    

    fid = fopen([dataDir,xmlFileName]); %opens the file
    tline = fgets(fid); %gets the line

    while ischar(tline)
        expression = '.*\<utf>\s(?<utf>.*)\s<\/utf\>.*';
        label = regexp(tline,expression,'names');
        labels = [labels;label];
        tline = fgets(fid); %gets the next line
    end
    fclose(fid);
end