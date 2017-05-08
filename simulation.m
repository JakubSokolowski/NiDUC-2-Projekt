%Load file
image = imread('testImage.png');
%Compute Signature
signature1 = crc32(image);
%test2
disp(signature1)
bitImage1=dec2bin(signature1);
%If repeat is set to 3, message needs to be repeated
repeat = 0;
count = 1;
bit=3;
chanceToFail = 0.95;
while bit>1 
    %Simulate sending message through channel with given chance to change the
    %message. Display the current received message signature and how many 
    %attempts took to send the message properly.
    bit=0;
    disp(count)
    count = count + 1;
    %Message after passing through communication chanel
    recived = sendData(image,chanceToFail);
    %Compute new signature
    signature2 = crc32(recived);
    bitImage2=dec2bin(signature2);
    disp(signature2)
    bit = bit + abs(length(find(bitImage1=='1'|bitImage1=='0'))-length(find(bitImage2=='1'|bitImage2=='0'))); 
    
end  

imshowpair(image,recived,'montage')

disp('Message sent succesfully') 