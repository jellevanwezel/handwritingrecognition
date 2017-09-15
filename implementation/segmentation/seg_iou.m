function [ iou ] = seg_iou( rectA, rectB, I)

binI = seg_binairy(I);
BW = imcomplement(binI);

padding = 100;

BW = [zeros(padding,size(BW,2)) ; BW ; zeros(padding,size(BW,2))];
BW = [zeros(size(BW,1),padding) , BW , zeros(size(BW,1),padding)];

aX = rectA(1) + padding;
aY = rectA(2) + padding;
aW = rectA(3);
aH = rectA(4);

bX = rectB(1) + padding;
bY = rectB(2) + padding;
bW = rectB(3);
bH = rectB(4);

minCol = min([aX,bX]);
maxCol = max([aX + aW,bX + bW]);
minRow = min([aY,bY]);
maxRow = max([aY + aH,bY + bH]);

canvasA =  zeros(size(BW));
canvasB =  zeros(size(BW));

canvasA(aY:aY+aH,aX:aX+aW) = BW(aY:aY+aH,aX:aX+aW);
canvasB(bY:bY+bH,bX:bX+bW) = BW(bY:bY+bH,bX:bX+bW);

intsec = and(canvasA,canvasB);
intSecArea = sum(intsec(:));
unionArea = sum(canvasA(:)) + sum(canvasB(:)) - intSecArea;
iou = intSecArea/unionArea;

% if(iou > 0.7)
% 
%     figure;
%     imshow(imcomplement(or(canvasA,canvasB)));
%     
%     waitforbuttonpress;
% end

end

