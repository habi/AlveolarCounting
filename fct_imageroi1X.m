%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                               %
%  23.04.2009                                    %
%                                                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [picture,rowup,rowdown,colleft,colright] = fct_imageroi1X(image)    

% Image is the name of the picture to be care of. Putt .tif after the name %

BW = image;
%I = image;
%Ic = imcomplement(I);
%BW = im2bw(Ic, graythresh(Ic));
[lastrow,lastcol] = size(BW);
errorfactor = 100;
rowup = 1;
outup = 0;
countup = 0;
while outup == 0
    maxup = max(BW(rowup,:));
    if maxup == 1
        countup = countup + 1;
    else
        countup = 0;
    end
    if countup == errorfactor
        outup = 1;
        rowup = rowup - errorfactor + 1;
    else    
        rowup = rowup + 1;
    end
end
rowup;
colright = lastcol;
outright = 0;
countright = 0;                   
while outright == 0
    maxright = max(BW(:,colright));
    if maxright == 1
        countright = countright + 1;
    else
        countright = 0;
    end
    if countright == errorfactor
        outright = 1;
        colright = colright + errorfactor - 1;
    else
        colright = colright - 1;
    end
end
colright;
colleft = 1;
outleft = 0;
countleft = 0;                   
while outleft == 0
    maxleft = max(BW(:,colleft));
    if maxleft == 1
        countleft = countleft + 1;
    else
        countleft = 0;
    end
    if countleft == errorfactor
        outleft = 1;
        colleft = colleft - errorfactor + 1;
    else
        colleft = colleft + 1;
    end
end
colleft;
rowdown = lastrow;
outdown = 0;
countdown = 0;
while outdown == 0
    maxdown = max(BW(rowdown,:));
    if maxdown == 1
        countdown = countdown + 1;
    else
        countdown = 0;
    end
    if countdown == errorfactor
        outdown = 1;
        rowdown = rowdown + errorfactor - 1;
    else    
        rowdown = rowdown - 1;
    end
end
rowdown;
%BW2 = BW(rowup:rowdown,colleft:colright);
picture = BW(rowup:rowdown,colleft:colright);
%figure, imshow(BW2), title('Roi Image');
%picture = I(rowup:rowdown,colleft:colright);
%figure, imshow(picture), title('original image roi');
end