clear all;
close all;
clc

warning off Images:initSize:adjustingMag

% [ Filename1, pathname1] = ...
%      uigetfile({'*.jpg;*.tif;*.png;*.gif','All Img Files';...
%           '*.*','All Files' },'First Img'); 
% Name = sprintf('First file: %s',Filename1);
% [ Filename2, pathname2] = ...
%      uigetfile({'*.jpg;*.tif;*.png;*.gif','All Img Files';...
%           '*.*','All Files' },Name,pathname1); 

SampleName = 'R108C21A2m_S2';
slice = 1000;
interval = 5;

Filename1 = [ SampleName sprintf('%04d',slice) '.rec.8bit.tif' ];
Filename2 = [ SampleName sprintf('%04d',slice+interval) '.rec.8bit.tif' ];

Path = 'R:\SLS\2009f\R108C21A2m_S2\rec_8bit\';

Img1 = imread([Path Filename1]);
Threshold1 =graythresh(Img1);
Bitdepth1 = intmax(class(Img1));
disp([ num2str(Filename1) ' has been Thresholded with ' num2str(Threshold1) ' (' num2str(Bitdepth1*Threshold1) ')' ]);
Img2= imread([ Path Filename2 ]);
Threshold2 =graythresh(Img2);
Bitdepth2 = intmax(class(Img2));
disp([ num2str(Filename2) ' has been Thresholded with ' num2str(Threshold2) ' (' num2str(Bitdepth2*Threshold2) ')' ]);

if isequal(Bitdepth1,Bitdepth2) == 0
    disp(['Img 1 and Img 2 do not have the same bit depth (' class(Bitdepth1) ' vs. ' class(Bitdepth1) '). I am stopping here!'])
end

img_thresh = im2bw(Img1,Threshold1);
img_label= bwlabeln(img_thresh);

%img_label(img_label<max(max(img_label)))=0;

% biggest_member =0;
% for i=1:n
%     biggest_member(i) = sum(sum(ismember(img_label,i)));
% end
% 
% [area_size,area_index]=max(biggest_member)
% img_biggestcomp=ismember(img_label,area_index);

% figure
%     subplot(121)
%         imshow(Img1,[])
% 	subplot(122)
%         imshow(img_thresh,[])

scrsz = get(0,'ScreenSize');
figure('Position',[1 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2])
    imshow(img_label,[])
    wait=helpdlg('Choose positive Points in shown picture. Stop with right mouse button',...
        'Selection');
	uiwait(wait)
    hold on % let me draw over stuff already drawn
    xy_pos = []; % empty coordinates at the beginning
    n = 0; % pointer to zero
    button = 1; % clicking with left mouse button keeps going, clicking another button ends the selection
    while button == 1 % abort if another mousebutton than 1 is pressed
        [xi,yi,button] = ginput(1);
        if button == 1 % only save point if left mouse button is pressed
            plot(xi,yi,'g+'); % plot the chosen points as 'r' red '+' crosses over the image
            n = n+1;
            xy_pos(:,n) = [xi,yi];
        end
    end
if size(xy_pos,2) >= 1 % If we haven't saved a positive point, we can proceed without showing it to the user
	figure('Position',[1 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2])
        imshow(Img1);
        hold on;
        plot(xy_pos(1,:),xy_pos(2,:),'go')
        title([ 'You chose these ' num2str(size(xy_pos,2)) ' positive Points'])
else
	xy_pos = [];
	warn=warndlg('You did not choose a positive Point. Proceeding...','Warning');
    uiwait(warn)
end

figure('Position',[1 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2])
    imshow(img_label,[])
    wait=helpdlg('Now choose negative Points in shown picture. Stop with right mouse button',...
    'Selection');
    uiwait(wait)
    hold on % let me draw over stuff already drawn
    xy = []; % empty coordinates at the beginning
    n = 0; % pointer to zero
    button = 1; % clicking with left mouse button keeps going, clicking another button ends the selection
    while button == 1
        [xi,yi,button] = ginput(1);
        if button == 1
            plot(xi,yi,'r+'); % plot the chosen points as 'r' red '+' crosses
            n = n+1;
            xy(:,n) = [xi,yi];
        end
    end
    xy_neg=xy;
figure('Position',[1 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2])
    imshow(Img1);
    title({[ num2str(size(xy_pos,2)) ' green circles as positive Points'];...
        [num2str(size(xy_neg,2)) ' red circles as negative Points']})
    if size(xy,2) >= 1
        hold on;
        if isempty(xy_pos)==0 
            plot(xy_pos(1,:),xy_pos(2,:),'go')
        end
        plot(xy_neg(1,:),xy_neg(2,:),'ro')
    else
        warn=warndlg('You did not choose a negative Point. Proceeding...',...
        'Warning');
        uiwait(warn)
        if isempty(xy_pos)==0 
            plot(xy_pos(1,:),xy_pos(2,:),'go')
        end
    end   

figure
	imshow(Img1);
    title([ num2str(size(xy_pos,2)) ' green circles as positive Points' ...
        num2str(size(xy_neg,2)) ' red circles as negative Points'])
    if size(xy_neg,2) >= 1
        hold on;
        if isempty(xy_pos)==0 
            plot(xy_pos(1,:),xy_pos(2,:),'go')
        end
        plot(xy_neg(1,:),xy_neg(2,:),'ro')
    else
        hold on
        if isempty(xy_neg)==0 
            plot(xy_pos(1,:),xy_pos(2,:),'go')
        else
            warn=warndlg('You did not choose one point at all. You might start again...',...
            'Warning');
        end
    end   

break
    
A = Img1(1:size(Img1,1),1:size(Img1,2));
L = A;
R1(1:size(L,1),1:size(L,2)) = 1;
G1(1:size(L,1),1:size(L,2)) = 0;
B1(1:size(L,1),1:size(L,2)) = 0;

Img2= imread([Path Filename2]);
Img2= im2bw(Img2,graythresh(Img2));
C = Img2(1:size(Img2,1),1:size(Img2,2));
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
figure,imshow(L),title('First Img');

E(1:size(C,1),1:size(C,2),1) = immultiply(C,R2);
E(1:size(C,1),1:size(C,2),2) = immultiply(C,G2);
E(1:size(C,1),1:size(C,2),3) = immultiply(C,B2);
figure,imshow(E),title('Second Img');

T = imadd(E,L);
From=350;
T = T(From:512+From,From:512+From,:);

figure,imshow(T),title('Superposition 1 & 2');
line([3,3],[1,692],'LineWidth',2,'Color',[1 0 0]);
line([size(T,2)-3,size(T,2)-3],[73,768],'LineWidth',2,'Color',[1 0 0]);
line([3,size(T,2)-3],[73,73],'LineWidth',2,'Color',[1 0 0]);
line([3,size(T,2)-3],[692,692],'LineWidth',2,'Color',[1 0 0]);

% clear directory_name;
% directory_name = uigetdir(pathname1) ;
% directory_name(size(directory_name,2)+1) = '\';
% InputDialog={'Give the name of the Img:'};
%             Name='File name';
%             NumLines=1;
%             ImgName = inputdlg(InputDialog,Name,NumLines);
%             ImgName = char(ImgName);
% directory_name(size(directory_name,2)+1 : size(directory_name,2) + size(ImgName,2)) = ImgName;
% directory_name(size(directory_name,2)+1 : size(directory_name,2)+4) = '.tif';
% imwrite(T,directory_name,'Compression','none'); 