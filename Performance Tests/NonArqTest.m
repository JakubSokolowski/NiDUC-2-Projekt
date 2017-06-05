function [ recived_good ] = NonArqTest( alg,noise,chance )
%NONARQTEST Summary of this function goes here
%   Detailed explanation goes here

image = imread('Test Images/512x512color.bmp');

signature1 = getParityBit(image);
repeat = 1;
while repeat
    %Simulate sending message through channel with given chance to change the
    %message. Display the current received message signature and how many 
    %attempts took to send the message properly.
    
    %Message after passing through communication chanel
    recived = sendDataWithSelectiveNoise(image,chance);
    
      % Noise Selection
        if noise == 1            
           recived = sendDataWithSelectiveNoise(image,chance);
        elseif noise == 2
           recived = sendDataWithAdjacentNoise(image,chance);
        elseif noise == 3
           recived = sendData(image,chance);          
        end
        
        % Algorithm Selection      
      
        if alg == 1
            signature1 = getParityBit(image);          
            signature2 = getParityBit(recived);
        elseif alg == 2
            signature1 = crc32(image);          
            signature2 = crc32(recived);
        elseif alg == 3
            signature1 = DataHash(image);          
            signature2 = DataHash(recived);
        end          
    %Repeat if needed
    repeat = compareSignatures(signature1,signature2);     
end  

if isequal(image,recived)
    recived_good = 1;
else
    recived_good = 0;
end

end

