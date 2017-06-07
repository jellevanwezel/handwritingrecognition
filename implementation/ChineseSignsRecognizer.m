clear all; 


%%%% Importing Data
disp('Importing data ............');
% cd('..');
% cd('dataset');
% cd('labeled');
%importingData  


%%%% Preprocessing


%%%% Segmentation 


%%%% Feature extraction
labeledSigns = importdata('labeledSigns.mat');

% Extract character geometry based features
%  cd('feature extraction');
%  features = zeros(85, length(labeledSigns));
%  
%  for i=1:length(labeledSigns)
%      features(:,i) = feature_extractor_test(labeledSigns{i});
%  end
%  cd('..');
% 
% 
% save('features.mat', 'features');

% Extract HOG features
cd('feature extraction');
cd('HOG');

HOGfeatures = HOG(labeledSigns{3});


%%%% Classifier 
% features = importdata('features.mat');
% labels = importdata('labels.mat');
% cd('classification');
% classification(features(1:85,:), labels);

disp('Feature extraction ............');
cd('..');
cd('dataset');
cd('Chinese-unicode-chars-ChaoMing');
imageFont1 = imread('utf-4e0a.jpg');
cd('..');
cd('Chinese-unicode-chars-CuoKai');
imageFont2 = imread('utf-4e0a.jpg');
cd('..');
cd('..');
cd('implementation');
figure;
size(imageFont1)
imageFont1=rgb2gray(imageFont1);
imageFont2=rgb2gray(imageFont2);

imageFont1 = imbinarize(imageFont1)
imageFont2 = imbinarize(imageFont2)



imageFont1 = bwmorph(imageFont1,'skel',inf)
imageFont2 = bwmorph(imageFont2,'skel',inf)
imshowpair(imageFont1, imageFont2, 'montage');
imageFont1 =discourser(imageFont1);
imageFont2 =discourser(imageFont2);
figure;
imshowpair(imageFont1, imageFont2, 'montage');


labeledSigns = importdata('labeledSigns.mat');
cd('feature extraction');
%feature_extraction(labeledSigns);
%features = feature_extractor_test(labeledSigns{1});

cd('..');

%%%% Classifier
