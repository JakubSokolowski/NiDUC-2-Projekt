function [bit] = noiseImage( x,disruptChance )

%   Detailed explanation goes here
x=0;
attributes = {'>=',0,'<=',1};
validateattributes(disruptChance,{'double'},attributes);
prob=rand;
if prob<disruptChance

    x = x+1;
else
    x = x;   
end
attributes = {'>=',0,'<=',1};
validateattributes(disruptChance,{'double'},attributes);
prob=rand;
if prob<disruptChance

    x = x+1;
else
    x = x;   
end
attributes = {'>=',0,'<=',1};
validateattributes(disruptChance,{'double'},attributes);
prob=rand;
if prob<disruptChance

    bit = x+1;
else
    bit = x;   
end

