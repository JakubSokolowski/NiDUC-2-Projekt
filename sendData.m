function [data] = sendData( x,disruptChance )
%disruptData - changes data with given probability, returns the changed
%data and its signature
%   Detailed explanation goes here

attributes = {'>=',0,'<=',1};
validateattributes(disruptChance,{'double'},attributes);
prob=rand;
if prob<disruptChance
    %Modify the data, compute the signature
    data = imnoise(x,'gaussian');
else
    data = x;   
end

