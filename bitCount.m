function [ m ] = bitCount(input)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
bin = dec2bin(str2num(input));
m = length(find(bin=='1'));
end

