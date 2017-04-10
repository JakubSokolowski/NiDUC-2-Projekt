%User input
prompt = 'Enter the filename: ';
%x = input(prompt);
filename = input(prompt,'s');
disp(filename);
%filename2 = input(prompt)

%Generating random strings
symbols = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

%find number of random characters to choose from
numRands = length(symbols); 

%specify length of random string to generate
stringLength = 10;

%generate random string
randString = symbols( ceil(rand(1,stringLength)*numRands) );

disp(randString)

%Returns height x width x 3 array
testImage = imread(filename);

%Creates noise of diffrent type and intensity;
testImage2 = imnoise(testImage,'gaussian');

%Random Intensity
%intensity = rand();
%testImage2 = imnoise(testImage,'salt & pepper',intensity);
%testImage2 = imnoise(testImage,'gaussian'.intensity);
%testImage2 = imnoise(testImage,'speckle');

%displays comprasion of immages
imshowpair(testImage,testImage2,'montage');



