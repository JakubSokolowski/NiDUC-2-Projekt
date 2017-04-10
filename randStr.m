function [ m ] = randStr( strlen )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
symbols = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
numRands = length(symbols); 
m = symbols( ceil(rand(1,strlen)*numRands) );
end

