clear;
segDir = '/home/jelle/RUG/HR/dataset/Train_segmented_run_4/';
outputDir = '/home/jelle/RUG/HR/dataset/Train_segmented_run_4t/';

mkdir(outputDir);

dirContents = dir(segDir);
for i = 1:size(dirContents,1)
    
    if(mod(i,60) == 0)
        disp([num2str(i/60),' %']);
    end
    
    folderName = dirContents(i).name;
    
    if ~dirContents(i).isdir
        continue;
    end
    
    mkdir([outputDir,folderName]);
    imageFolderContents = dir([segDir,folderName]);
    
    for j = 3:size(imageFolderContents,1)
        fileName = imageFolderContents(j).name;
    
        if ~all(fileName(end-3:end) == '.png')
            continue;
        end
        
        A = imread(strcat(segDir,folderName,'/',fileName));
        
        A = imcomplement(A);
        
        trimTop = 0;
        
        for row = 1 : size(A,1)
            if(sum(A(row,:)) == 0 )
                trimTop = trimTop + 1;
            else
                break;
            end
        end
        
        trimBot = 0;
        
        for row = fliplr(1 : size(A,1))
            if(sum(A(row,:)) == 0 )
                trimBot = trimBot + 1;
            else
                break;
            end
        end
        
        
        
        expression = '.*-x=(?<x>[-+]?\d+)-y=(?<y>[-+]?\d+)-w=(?<w>[-+]?\d+)-h=(?<h>[-+]?\d+).*';
        cords = regexp(fileName,expression,'names');
        
        x = str2num(cords.x);
        y = str2num(cords.y);
        w = str2num(cords.w);
        h = str2num(cords.h);
        
        y = y + trimTop;
        h = h - (trimTop + trimBot);
        A = A(trimTop + 1:end-trimBot,:);
        
        newCordsName = strcat(num2str(j),'-x=',num2str(x),'-y=',num2str(y),'-w=',num2str(w),'-h=',num2str(h));
        
        imgWriteName = [outputDir,folderName,'/',newCordsName,'.png'];
        
        imwrite(imcomplement(A),imgWriteName);
        
        
    end
       
end