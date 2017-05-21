image = imread('Test Images/512x512.png');
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

blocksReceived = zeros(9,9);
repeat = 1;
while repeat
    
for r = 1 : blockRow
    for c = 1 : blockColumn
        
        %If the block is marked as received, move to the next one
        if(blocksReceived(r,c) == 1)
            continue
        end
        %Send the block, place it in the received cell array
        cellReceived{r,c} = sendData(cellMessage{r,c},0.9);
        
        %Calculate the signatures
        send = getParityBit(cell2mat(cellMessage(r,c)));          
        received = getParityBit(cell2mat(cellReceived(r,c)));
        
        %If the signatures match, mark the current block as received
        %properly
        if(send == received)
            blocksReceived(r,c) = 1;
        end
        
        %Go to the next block
        blockIndex = blockIndex + 1;      
    
        %If all the blocks are marked as received stop
        if(sum(sum(blocksReceived)) == 81)
            repeat = 0;
        end
    end
    
end
    %Display which blocks are received
    disp(blocksReceived)
end;


%Convert cell array to image
receivedImage = cell2mat(cellReceived);
imshowpair(image,receivedImage,'montage')

disp('Message Hash')
disp(DataHash(image))
disp('Received Message Hash')
disp(DataHash(receivedImage))