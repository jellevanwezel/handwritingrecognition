cd('Train');

imageFiles = dir('*.pgm');
nSentences = length(imageFiles)



for i=1:1 %%% aanpassen in nSentences
   currentfilename = imageFiles(i).name;
   currentimage = imread(currentfilename);
   T = adaptthresh(currentimage, 0.4);
   BW = imbinarize(currentimage, T);
   imshowpair(currentimage,BW,'montage')
   chineseSentences{i} = BW;
end




cd('..');