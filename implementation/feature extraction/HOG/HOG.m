function [HOGfeatures] = HOG(signs)

[HOGfeatures,hogVisualization] = extractHOGFeatures(signs);

HOGfeatures
figure;
imshow(signs);
hold on;
plot(hogVisualization);

end

