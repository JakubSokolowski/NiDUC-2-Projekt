%Load file
image = imread('testImage.png');
%Set property of encoding function
%Compute Signature
signature1 = getParityBit(image);
%test2
disp(signature1)


%If repeat is set to 1, message needs to be repeated
repeat = 1;
count = 1;
chanceToFail = 0.95;
while repeat
    %Simulate sending message through channel with given chance to change the
    %message. Display the current received message signature and how many 
    %attempts took to send the message properly.
    disp(count)
    count = count + 1;
    %Message after passing through communication chanel
    recived = sendData(image,chanceToFail);
    %Compute new signature
    signature2 = getParityBit(recived);
    disp(signature2)
    %Repeat if needed
    repeat = compareSignatures(signature1,signature2);     
end  


imshowpair(image,recived,'montage');

disp('Message sent succesfully')