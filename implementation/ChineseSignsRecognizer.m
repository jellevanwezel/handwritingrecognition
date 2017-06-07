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







