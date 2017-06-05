function [ data ] = sendDataWithAdjacentNoise( x, disruptChance )
%SENDDATAWITHADJACENTNOISE Summary of this function goes here
%   Detailed explanation goes here

attributes = {'>=',0,'<=',1};
validateattributes(disruptChance,{'double'},attributes);
prob=rand;
if prob<disruptChance
    %Modify the data, compute the signature
    data = adjacentNoise(x,5);
else
    data = x;   
end

