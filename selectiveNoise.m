function [ image ] = selectiveNoise( image, n )
% Negate given number of pixels in image
%   Detailed explanation goes here

%Repeat the loop n times
for c = 1:n
    %Choose random coordinates in image
    x = randi([1,size(image,1)]);
    y = randi([1,size(image,2)]);
    %Choose random color (r,g,b)
    z = randi([1,3]);
    %Convert random pixel to binary string
    randomPixel = dec2bin(image(x,y,z));
    %Choose random place in string
    index = randi([1,length(randomPixel)]);
    %Negate the bit
    if(randomPixel(index) == 1) 
        randomPixel(index) = int2str(0);
    else
        randomPixel(index) = int2str(1);
    end;
    %Put the pixel with changed color value back in old place
    image(x,y,z) = bin2dec(randomPixel);
end;

end

