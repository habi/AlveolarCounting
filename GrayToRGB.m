clear all;
close all;
clc

[ filename1, pathname1] = ...
     uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' },'First Image'); 
Name = sprintf('First file: %s',filename1);
[ filename2, pathname2] = ...
     uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' },Name,pathname1); 
 
image1 = imread([pathname1 filename1]);
A = image1(1:size(image1,1),1:size(image1,2));
L = A;
R1(1:size(L,1),1:size(L,2)) = 1;
G1(1:size(L,1),1:size(L,2)) = 0;
B1(1:size(L,1),1:size(L,2)) = 0;

image2 = imread([pathname2 filename2]);
C = image2(1:size(image2,1),1:size(image2,2));
E = C;
R2(1:size(E,1),1:size(E,2)) = 0;
G2(1:size(E,1),1:size(E,2)) = 1;
B2(1:size(E,1),1:size(E,2)) = 1;

if max(max(A)) < 256
    R1 = uint8(R1);
    G1 = uint8(G1);
    B1 = uint8(B1);
    R2 = uint8(R2);
    G2 = uint8(G2);
    B2 = uint8(B2);
else 
    R1 = uint16(R1);
    G1 = uint16(G1);
    B1 = uint16(B1);
    R2 = uint16(R2);
    G2 = uint16(G2);
    B2 = uint16(B2);
end

L(1:size(A,1),1:size(A,2),1) = immultiply(A,R1);
L(1:size(A,1),1:size(A,2),2) = immultiply(A,G1);
L(1:size(A,1),1:size(A,2),3) = immultiply(A,B1);
figure,imshow(L),title('First image');

E(1:size(C,1),1:size(C,2),1) = immultiply(C,R2);
E(1:size(C,1),1:size(C,2),2) = immultiply(C,G2);
E(1:size(C,1),1:size(C,2),3) = immultiply(C,B2);
figure,imshow(E),title('Second image');

T = imadd(E,L);

figure,imshow(T),title('Superposition 1 & 2');
line([3,3],[1,692],'LineWidth',2,'Color',[1 0 0]);
line([size(T,2)-3,size(T,2)-3],[73,768],'LineWidth',2,'Color',[1 0 0]);
line([3,size(T,2)-3],[73,73],'LineWidth',2,'Color',[1 0 0]);
line([3,size(T,2)-3],[692,692],'LineWidth',2,'Color',[1 0 0]);

clear directory_name;
directory_name = uigetdir(pathname1) ;
directory_name(size(directory_name,2)+1) = '\';
InputDialog={'Give the name of the image:'};
            Name='File name';
            NumLines=1;
            imageName = inputdlg(InputDialog,Name,NumLines);
            imageName = char(imageName);
directory_name(size(directory_name,2)+1 : size(directory_name,2) + size(imageName,2)) = imageName;
directory_name(size(directory_name,2)+1 : size(directory_name,2)+4) = '.tif';
imwrite(T,directory_name,'Compression','none'); 