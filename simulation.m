%Load file
image = imread('TestImages/testImage.png');
%Compute Signature
signature1 = crc32(image);
%test2
disp(signature1)
bitImage1=dec2bin(signature1);
%If bit is set to 3, message needs to be repeated
repeat = 0;

count = 1;
bit=3;
chanceToFail = 0.95;
while bit>1 
%If bit is set to 2 or 3, message needs to be repeated
repeat = 3;
count = 1;
bit=3;
chanceToFail = 0.50;
while bit>1
    %Simulate sending message through channel with given chance to change the
    %message. Display the current received message signature and how many 
    %attempts took to send the message properly.
    bit=0;
    disp(count)
    count = count + 1;
    %Message after passing through communication chanel
    received = sendData(image,chanceToFail);
    %Compute new signature
    signature2 = crc32(received);
    bitImage2=dec2bin(signature2);
    disp(signature2)
    bit = bit + abs(length(find(bitImage1=='1'|bitImage1=='0'))-length(find(bitImage2=='1'|bitImage2=='0'))); 
end  

imshowpair(image,received,'montage')
    signature2 = crc32(received);
    disp(signature2)
    bit=noiseImage(bit,chanceToFail);
    if bit<2
    bit = compareSignatures( signature1, signature2 );
    end
    
end  

imshowpair(image,received,'montage')

disp('Message sent succesfully') 