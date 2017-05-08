%Load file
image = imread('testImage.png');
%Compute Signature
signature1 = crc32(image);
%test2
disp(signature1)

%If bit is set to 3, message needs to be repeated
repeat = 0;
count = 1;
bit=3;
chanceToFail = 0.95;
while bit>2 
    %Simulate sending message through channel with given chance to change the
    %message. Display the current received message signature and how many 
    %attempts took to send the message properly.
    disp(count)
    count = count + 1;
    %Message after passing through communication chanel
    recived = sendData(image,chanceToFail);
    %Compute new signature
    signature2 = crc32(recived);
    disp(signature2)
    bit=0;
    bit = bit + compareSignatures(signature1,signature2);
    if compareSignatures(signature1,signature2)==0
        imshowpair(image,recived,'montage');
    end
    
    recived = sendData(image,chanceToFail);
    signature2 = crc32(recived);
    disp(signature2)
    bit = bit + compareSignatures(signature1,signature2);
    if compareSignatures(signature1,signature2)==0
        imshowpair(image,recived,'montage');
    end
    
    recived = sendData(image,chanceToFail);
    signature2 = crc32(recived);
    disp(signature2)
    bit = bit + compareSignatures(signature1,signature2);
    if compareSignatures(signature1,signature2)==0
        imshowpair(image,recived,'montage');
    end   
    
end  


disp('Message sent succesfully')