clear all; 

%%%%%%%%%%%%% Settings %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
importLabeledSigns = false; 
loadLabeledSigns = true;

importAllFonts = false;
loadAllFonts = false;

resizeLabeledTo100x100 = false;
loadLabeled100x100 = true;

resizeLabeledToAverage = false;
loadResizedLabeledAverage= false;

extractGEOfeatures = false;
loadGEOfeatures = true;

extractHOGfeatures = false;
loadHOGfeatures = false;
classify = true;

%%%%% Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
par.classifier = 'KNN';
par.perTrain = 0.70;
par.numOfNeighbors = 1;
par.normalizeFeatures = true;
par.importKNNmodel = false;
par.tenfoldcross = true;
par.splitTrainTest = false;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%% Importing Data 
disp('Importing data ............');

%%% Import labeled signs
if importLabeledSigns
    importingData
elseif loadLabeledSigns
    signs = importdata('labeledSigns.mat');
    labels = importdata('labels.mat');
    fonts = importdata('fonts.mat');
    % Delete instances without labels %%%%% MOVE TO IMPORTING DATA IF
    % importingData IS EXECUTED AGAIN!!
    instancesWithoutLabels = find(cellfun(@isempty,labels));
    signs(:,instancesWithoutLabels) = [];
    labels(:,instancesWithoutLabels) = [];
    fonts(:,instancesWithoutLabels) = [];
end
    
%%% Import font signs
if importAllFonts
    [ChaoMingSigns, ChaoMingLabels] = importFontSigns('Chinese-unicode-chars-ChaoMing');
    [CuoKaiSigns, CuoKaiLabels] = importFontSigns('Chinese-unicode-chars-CuoKai');
    [HeiTiSigns, HeiTiLabels] = importFontSigns('Chinese-unicode-chars-HeiTi');
    [MingTiSigns, MingTiLabels] = importFontSigns('Chinese-unicode-chars-MingTi');
    [TeMingSigns, TeMingLabels] = importFontSigns('Chinese-unicode-chars-TeMing');
    [XinSongSigns, XinSongLabels] = importFontSigns('Chinese-unicode-chars-XinSong');
    [YanKaiSigns, YanKaiLabels] = importFontSigns('Chinese-unicode-chars-YanKai');
    
    allFontsSigns = [ChaoMingSigns, CuoKaiSigns, HeiTiSigns, MingTiSigns, TeMingSigns, XinSongSigns, YanKaiSigns];
    allFontsLabels = [ChaoMingLabels, CuoKaiLabels, HeiTiLabels, MingTiLabels, TeMingLabels, XinSongLabels, YanKaiLabels];
    
    save('allFontsSigns.mat', 'allFontsSigns');
    save('allFontsLabels.mat', 'allFontsLabels');
elseif loadAllFonts
    signs = importdata('allFontsSigns.mat');
    labels = importdata('allFontsLabels.mat');
end

%%% Resize to size 100x100 pixels
if resizeLabeledTo100x100
    for i=1:length(signs) % Count should be equal to total number of images in allImages array
        resizedSigns{i} = imresize(signs{i}, [100 100]);  % Could change and experiment with the interpolation method
    end
    save('resizedSigns100.mat', 'resizedSigns');
elseif loadLabeled100x100
    signs = importdata('resizedSigns100.mat');
end

%%% Resize images to average heigth/width, needed for HOG features
if resizeLabeledToAverage
    totalWidth=0;
    totalHeigth=0;
    size(signs)
    for i=1:length(signs)
        [x1,y1,z1] = size(signs{i});
        totalWidth = totalWidth + x1;
        totalHeigth = totalHeigth + y1;
    end

    avgWidth = round(totalWidth/length(signs));
    avgHeigth = round(totalHeigth/length(signs));

    for i=1:length(signs) % Count should be equal to total number of images in allImages array
        [x1,y1,z1] = size(signs(i));
        resizedSigns{i} = imresize(signs{i}, [avgWidth avgHeigth]);  % Could change and experiment with the interpolation method
    end 

    save('resizedSigns.mat', 'resizedSigns');
elseif loadResizedLabeledAverage
    signs = importdata('resizedSigns.mat');
end


%%%% Segmentation 
disp('Segmentation............');



%%%% Feature extraction
disp('Extract Features............');

%Extract character geometry based features
if extractGEOfeatures
    cd('feature extraction\Character_Geometry');
    %GEOfeatures = zeros(85, length(labeledSigns));
 
    for i=1:length(signs)
        GEOfeatures(:,i) = feature_extractor_test(signs{i});
        i
    end
    cd('..');
    cd('..');
    save('GEOfeatures.mat', 'GEOfeatures');
    features = GEOfeatures;
elseif loadGEOfeatures
    features = importdata('GEOfeatures.mat');
end

%Extract HOG features
if extractHOGfeatures
    cd('feature extraction\HOG');
 
    for i=1:length(labeledSigns)
        HOGfeatures(:,i) = HOG(resizedSigns{i});
        i
    end
    cd('..');
    cd('..');
    save('HOGfeaturesAllFonts.mat', 'HOGfeatures'); 
elseif loadHOGfeatures
    features = importdata('HOGfeatures.mat');
end




%%%% Classifier 
disp('Train and classify............');

if classify
    cd('classification');
    classification(features, labels, par);
    cd('..');
elseif onlyTrain
    
    
end

