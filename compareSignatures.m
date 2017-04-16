function [ repeat ] = compareSignatures( signature1, signature2 )
%compareSignatures - checks if message was transmitted correctly
%
if signature1 == signature2
    repeat = 0;
else
    repeat = 1;
end

