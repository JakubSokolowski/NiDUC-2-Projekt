function [data] = sendDataWithSelectiveNoise( x, disruptChance )
%disruptData - changes data with given probability, returns the changed
%data and its signature
%   Detailed explanation goes here

attributes = {'>=',0,'<=',1};
validateattributes(disruptChance,{'double'},attributes);
prob=rand;
if prob<disruptChance
    %Modify the data, compute the signature
    data = selectiveNoise(x,10);
else
    data = x;   
end