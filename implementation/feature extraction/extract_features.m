function [ features ] = extract_features(I, edgeMethod)
Is = window_maker(I);
features = nan(1,22);
for index = 1 : length(Is)
    imageWindow = Is{index};
    startIdx = (index * 5) - 5;
    features(1,startIdx + 1) = bw_ratio(imageWindow);
    features(1,startIdx + 2) = edge_ratio(imageWindow,edgeMethod,'h');
    features(1,startIdx + 3) = edge_ratio(imageWindow,edgeMethod,'v');
    features(1,startIdx + 4) = edge_ratio(imageWindow,edgeMethod,'dl');
    features(1,startIdx + 5) = edge_ratio(imageWindow,edgeMethod,'dr');
end
features(1,21:end) = size(I);
end