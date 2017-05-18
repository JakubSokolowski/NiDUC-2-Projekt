%Load file
image = imread('testImage.png');
rndsample = datasample(image,3,'Replace',false);
x = randi([1,size(image,1)]);
y = randi([1,size(image,2)]);
z = randi([1,3]);
randomPixel = dec2bin(image(x,y,z));
randomPixel2 = randomPixel;
index = randi([1,length(randomPixel)]);
if(randomPixel2(index) == 1) 
    randomPixel2(index) = int2str(0);
else
    randomPixel2(index) = int2str(1);
end;
randomPixel3 = bin2dec(randomPixel2);
image(x,y,z) = randomPixel3;

disp(image(x,y,z))
    