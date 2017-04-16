%User input
prompt = 'Enter the filename: ';
%x = input(prompt);
filename = input(prompt,'s');
disp(filename);
%filename2 = input(prompt)

%generate random string
randString = randStr(20);
disp(randString)

%Returns height x width x 3 array
testImage = imread(filename);

%Creates noise of diffrent type and intensity;
testImage2 = imnoise(testImage,'gaussian');

disp(crc32(testImage))
disp(crc32(testImage2))
%Random Intensity
%intensity = rand();
%testImage2 = imnoise(testImage,'salt & pepper',intensity);
%testImage2 = imnoise(testImage,'gaussian'.intensity);
%testImage2 = imnoise(testImage,'speckle');

%displays comparison of immages
imshowpair(testImage,testImage2,'montage');



