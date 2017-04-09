
%Returns height x width x 3 array
testImage = imread('shipCollision.jpg');

%
testImage2 = imnoise(testImage,'gaussian');

imshowpair(testImage,testImage2,'montage');



