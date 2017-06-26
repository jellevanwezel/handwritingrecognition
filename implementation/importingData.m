%%
cd('..');
cd('dataset');
cd('Train');

addpath('C:\Users\lvand\Documents\RUG\Handwriting Recognition\handwritingrecognition\implementation\segmentation');
mkdir('../labeled/');

imageFiles = dir('*.pgm');
nSentences = length(imageFiles);

labelFiles = dir('*.xml');
nLabels = length(labelFiles);

j=1;
for i=1:nSentences %%% aanpassen in nSentences voor alle data
   currentFileName = imageFiles(i).name;
   currentImage = imread(currentFileName);
   
   currentLabelName = labelFiles(i).name;
   currentLabel = fopen(currentLabelName);
   
   curFileDirName = strcat('../labeled/',currentFileName(1:end-4),'/');
   mkdir(curFileDirName);

    tline = fgetl(currentLabel);
    while ischar(tline)
        disp(tline)
          
        x = str2double(regexp(tline, '(?<=x=)[0-9]+', 'match'));
        y = str2double(regexp(tline, '(?<=y=)[0-9]+', 'match'));
        w = str2double(regexp(tline, '(?<=w=)[0-9]+', 'match'));
        h = str2double(regexp(tline, '(?<=h=)[0-9]+', 'match'));
            
        fonts{j} = regexp(tline, '(?<=<txt>)@\w*'  , 'match'); 
        labels{j} = regexp(tline, '(?<=<utf> )[0-9]+\w*'  , 'match');
        labeledSigns{j} = imcrop(seg_binairy(currentImage), [x, y, w, h]);
         
        %imshow(labeledSigns{j}); 
        curLabel = char(labels{j});
        curFont = char(fonts{j});
        locationString = strcat('-x=',num2str(x),'-y=',num2str(y),'-w=',num2str(w),'-h=',num2str(h));
        labelFont = strcat('-l=',curLabel,'-f=',curFont(2:end));
        charImageName = strcat(curFileDirName,locationString,labelFont,'.png');
        imwrite(labeledSigns{j},charImageName);
        
        tline = fgetl(currentLabel);
        j = j+1;
    end

    fclose(currentLabel);
   
   chineseSentences{i} = currentImage;
end



cd('..');
cd('..');
cd('implementation');

save('labeledSigns.mat', 'labeledSigns'); 
save('labels.mat', 'labels');
save('fonts.mat', 'fonts');
