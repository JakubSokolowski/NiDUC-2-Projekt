function [ parity_bit ] = getParityBit( data )
%getParityBit Returns 1 if the count of 1 bits is even
%Converts the data to binary array, calls sum to add all elements,
%then checks if the result is even or odd

data = dec2bin(data);
count = sum(sum(data));
if(mod(count,2)==2)
    parity_bit = 0;
else
    parity_bit = 1;
end

end

