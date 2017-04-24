%Load file
image = imread('testImage.png');
%Compute Signature
signature1 = crc32(image);

disp(signature1)

%If repeat is set to 1, message needs to be repeated
repeat = 1;
count = 1;
chanceToFail = 0.65;
while repeat
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
    %Repeat if needed
    repeat = compareSignatures(signature1,signature2);     
end  

imshowpair(image,recived,'montage');

disp('Message sent succesfully')