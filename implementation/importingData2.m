%%
cd('..');
cd('dataset');
cd('Train');

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
   

    tline = fgetl(currentLabel);
    while ischar(tline)
        disp(tline)
          
        x = str2double(regexp(tline, '(?<=x=)[0-9]+', 'match'));
        y = str2double(regexp(tline, '(?<=y=)[0-9]+', 'match'));
        w = str2double(regexp(tline, '(?<=w=)[0-9]+', 'match'));
        h = str2double(regexp(tline, '(?<=h=)[0-9]+', 'match'));
        
        if(isempty(regexp(tline, '(?<=<txt>)@\w*'  , 'match')) | isempty(regexp(tline, '(?<=<utf> )[0-9]+\w*'  , 'match'))) 
            tline = fgetl(currentLabel);
        else
            fonts(j) = regexp(tline, '(?<=<txt>)@\w*'  , 'match'); 
            labels(j) = regexp(tline, '(?<=<utf> )[0-9]+\w*'  , 'match');
            labeledSigns{j} = imbinarize(imcrop(currentImage, [x, y, w, h])); %%% Binarization done for test
            j = j+1;
            tline = fgetl(currentLabel);
        end
            
    end

    fclose(currentLabel);
   
   chineseSentences{i} = imbinarize(currentImage); %%% Binarization done for test
end

cd('..');
cd('..');
cd('implementation');


save('sentences.mat', 'chineseSentences'); 
save('labeledSigns.mat', 'labeledSigns');
save('labels.mat', 'labels');
save('fonts.mat', 'fonts');