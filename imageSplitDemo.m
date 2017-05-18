
rgbImage = imread('512x512.png');

% Display image full screen.
imshow(rgbImage);
% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
drawnow;
% Get the dimensions of the image.  numberOfColorBands should be = 3.
[rows, columns, numberOfColorBands] = size(rgbImage);

%Divide an image up into blocks is by using mat2cell().
blockSizeR = 64; % Rows in block.
blockSizeC = 64; % Columns in block.

% Figure out the size of each block in rows.
% Most will be blockSizeR but there may be a remainder amount of less than that.
wholeBlockRows = floor(rows / blockSizeR);
blockVectorR = [blockSizeR * ones(1, wholeBlockRows), rem(rows, blockSizeR)];

% Figure out the size of each block in columns.
wholeBlockCols = floor(columns / blockSizeC);
blockVectorC = [blockSizeC * ones(1, wholeBlockCols), rem(columns, blockSizeC)];

% Create the cell array, ca. 
% Each cell (except for the remainder cells at the end of the image)
% in the array contains a blockSizeR by blockSizeC by 3 color array.
% This line is where the image is actually divided up into blocks.
if numberOfColorBands > 1
    % It's a color image.
    ca = mat2cell(rgbImage, blockVectorR, blockVectorC, numberOfColorBands);
else
    ca = mat2cell(rgbImage, blockVectorR, blockVectorC);
end

% Now display all the blocks.
plotIndex = 1;
numPlotsR = size(ca, 1);
numPlotsC = size(ca, 2);
for r = 1 : numPlotsR
    for c = 1 : numPlotsC
        % Specify the location for display of the image.
        subplot(numPlotsR, numPlotsC, plotIndex);
        rgbBlock = ca{r,c};
        rgbBlock = sendData(rgbBlock,0.50);
        imshow(rgbBlock); % Could call imshow(ca{r,c}) if you wanted to.
        [rowsB, columnsB, numberOfColorBandsB] = size(rgbBlock);
        drawnow;
        % Increment the subplot to the next location.
        plotIndex = plotIndex + 1;
    end
end

% Display the original image in the upper left.
%subplot(4, 6, 1);
%imshow(rgbImage);
%title('Original Image');