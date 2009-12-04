clc;
clear;
close all;


[ filename1, pathname1] = ...
     uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' }); 
A = imread([pathname1 filename1]);
figure, imshow(A);
A = imresize(A,0.75);
detA = fct_thresholdSRXTM244(A);
figure, imshow(detA);
[detA,rowupA,rowdownA,colleftA,colrightA]= fct_imageroigray(detA);
detA = A(rowupA:rowdownA,colleftA:colrightA);
figure, imshow(detA);

%detA = A;
%magnification1 = sqrt(600 / (size(A,1)*size(A,2)));
%detA = imresize(A,magnification1);  
  
[filenamefirst, pathname2, filenamelast, first...
        , last, counterfirst, counterlast] = fct_multiplefileopen2;
InputDialog={'Give the step between two analysed images:'};
Name='Step';
NumLines=1;
step = inputdlg(InputDialog,Name,NumLines);
step = str2num(step{1});

correlationstep = 0;
filename2 = filenamefirst;
LoopCount = 0;
correlation = 0;
for p=first:step:last 
    LoopCount = LoopCount + 1
    filename2(counterfirst:counterlast) = sprintf('%04d', p)
    B = imread([pathname2 filename2]);
    B = imresize(B,0.75);
    detB = fct_thresholdSRXTM244(B);
    [detB,rowupB,rowdownB,colleftB,colrightB]= fct_imageroigray(detB);
    detB = B(rowupB:rowdownB,colleftB:colrightB);
    %figure, imshow(detB);
    if size(detA,1) < size(detB,1)
        end1c = size(detA,1);
    else
        end1c = size(detB,1);
    end
    
    if size(detA,2) < size(detB,2)
        end2c = size(detA,2);
    else
        end2c = size(detB,2);
    end
    
    c = normxcorr2(detA(1:end1c,1:end2c),detB(1:end1c,1:end2c));
    
    correlationstep = max(max(c))
    if correlationstep > correlation
            correlation = correlationstep;
            filenamebest = filename2;
    end
end
    

Ref = filename1
Best_correlation = filenamebest