function [ recived_good ] = ArqTest( alg,noise,chance )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

image = imread('Test Images/512x512color.bmp');
%rgbImage = imread('Test Images/512x512.png');
% Get the dimensions of the image.  numberOfColorBands should be = 3.
[rows, columns, numberOfColorBands] = size(image);

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
    cellMessage = mat2cell(image, blockVectorR, blockVectorC, numberOfColorBands);
else
    cellMessage = mat2cell(image, blockVectorR, blockVectorC);
end

%Create the cell array that holds the received message
cellReceived = cell(size(cellMessage));

blockIndex = 1;
blockRow = size(cellMessage, 1);
blockColumn = size(cellMessage, 2);

%Create bool array, with information which blocks were received properly.
%Set all the initial values to 0
blocksReceived = zeros(9,9);

num_received_good = 0;
repeat = 1;
while repeat
for r = 1 : blockRow
    for c = 1 : blockColumn
        
        %If the block is marked as received, move to the next one
        if(blocksReceived(r,c) == 1)
            continue
        end
     
        % Noise Selection
        if noise == 1            
           cellReceived{r,c} = sendDataWithSelectiveNoise(cellMessage{r,c},chance);
        elseif noise == 2
           cellReceived{r,c} = sendDataWithAdjacentNoise(cellMessage{r,c},chance);
        elseif noise == 3
           cellReceived{r,c} = sendData(cellMessage{r,c},chance);           
        end
        
        % Algorithm Selection      
      
        if alg == 1
            send = getParityBit(cell2mat(cellMessage(r,c)));          
            received = getParityBit(cell2mat(cellReceived(r,c)));
        elseif alg == 2
            send = crc32(cell2mat(cellMessage(r,c)));          
            received = crc32(cell2mat(cellReceived(r,c)));
        elseif alg == 3
            send = DataHash(cell2mat(cellMessage(r,c)));          
            received = DataHash(cell2mat(cellReceived(r,c)));
        end          
              
        if(send == received)
            blocksReceived(r,c) = 1;
            if isequal(cellMessage{r,c},cellReceived{r,c})
                num_received_good = num_received_good + 1;
            end
                
        end
        
        %Go to the next block
        blockIndex = blockIndex + 1;      
    
        %If all the blocks are marked as received stop
        if(sum(sum(blocksReceived)) == 81)
            repeat = 0;
        end
    end
    
end
end;

%imshowpair(receivedImage,image,'diff')
%imshowpair(image,receivedImage,'diff')
%imshowpair(image,K,'montage');

percent_received = num_received_good / 81;
recived_good = [0,percent_received];



end

