
A = [1014,169,67,97]; %rectangle 1
B = [1014,149,74,114]; %rectangle 2

interArea = rectint(A,B); %intersection area
unionArea = A(3) * A(4) + B(3) * B(4) - interArea; %union area
iou = interArea / unionArea; % intersection over union

iou