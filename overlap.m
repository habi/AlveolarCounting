clc;
clear;
close all;


[ filename1, pathname1] = ...
     uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' }); 
A = imread([pathname1 filename1]);
A = A(1:size(A,1),1:size(A,2));
%figure, imshow(A);
[detA,level] = fct_thresholdSRXTMLevel(A);
%[detA,rowup,rowdown,colleft,colright] = fct_imageroi1X(detA);
figure, imshow(detA);

Name = sprintf('First file: %s',filename1);
[ filename1, pathname1] = ...
     uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' },Name,pathname1); 
B = imread([pathname1 filename1]);
B = B(1:size(B,1),1:size(B,2));
%figure, imshow(B);

BW = im2bw(B, level);
se = strel('disk', 4);
BWc = imclose(BW, se);
BW2 = IMFILL(BWc,'holes');
BW3 = bwareaopen(BW2,100);
detB = immultiply(BW,BW3);
detB = (detB>0);
%detB = detB(rowup:rowdown,colleft:colright);
figure, imshow(detB);

detA1 = detA * 20;   
detA1 = uint16(detA1);
detA1 = double(detA1);
detB1 = detB * 40;    
detB1 = uint16(detB1);
detB1 = double(detB1);
C = imadd(detB1,detA1);
figure
image(C);
%axis off          
axis image