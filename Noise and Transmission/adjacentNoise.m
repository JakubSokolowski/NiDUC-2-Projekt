function [ image ] = adjacentNoise( image, n )
%ADJACENTNOISE Summary of this function goes here
%   Detailed explanation goes here

old_image = image;
[column,row] = size(image);

if(1 <= (row-n) && 1<= column)
    x = randi([1,column]);
    y = randi([1,(row-n)]); 
for c = 1:n  
 
    image(x,y,1) = 1;
    image(x,y,2) = 1;
    image(x,y,3) = 1;
    y = y+1;
end;
else
   image = old_image;
end

end

