%Load file
image = imread('testImage.png');
%Compute Signature
signature1 = crc32(image);

disp(signature1)

repeat = 1;
count = 1;
chanceToFail = 0.8;
while repeat
    %Simulate sending message through channel with 80% chance to change the
    %message. Display how many attempts took to send the message properly.
    disp(count)
    count = count + 1;
    %Message after passing through communication chanel
    recived = sendData(image,chanceToFail);
    %compute new signature
    signature2 = crc32(recived);
    disp(signature2)
    %repeat if needed
    repeat = compareSignatures(signature1,signature2);     
end  

imshowpair(image,recived,'montage');

disp('Message sent succesfully')