function [ labels ] = match_labels( labeled, fileNames )

labels = cell(size(fileNames));

prevP = 0;

for i = 1 : length(fileNames)
    fileName = fileNames{i,1};
    
    
     if floor(i / size(fileNames,1) * 100) > prevP
        prevP = floor(i / size(fileNames,1) * 100);
        disp([num2str(prevP), ' %']);
     end

     for j = 1 : length(labeled)
         labelCell = labeled{j,1};
         labelFile = labelCell{1};
         
%          if all(size(labelFile) == size(fileName))
%             disp(labelFile)
%             disp(fileName)
%          end
         
         if strcmp(labelFile, fileName)
             labels{i,1} = labeled{j,2};
             break;
         end
     end
    
end

