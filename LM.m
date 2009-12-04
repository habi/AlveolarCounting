clear all;
close all;
clc

%%%%%%%%%%%% Open and set the region of interest of EM picture %%%%%%%%%%

[ filenameLm, pathnameLm] = ...
     uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' }); 
 
imageLM = imread([pathnameLm filenameLm]);
%imageLM = imread('\\Anadata\u\Gruppe_Schittny\images\Sebastien\FotosR108C21C\R108C21C-014.tif');
imageLM = imageLM(1:size(imageLM,1),1:size(imageLM,2));
mask1 = fct_thresholdLm244(imageLM);
mask1 = fct_imageroi1(mask1);
lowerlimitLM = min(min(imageLM));
upperlimitLM = max(max(imageLM));
out = 0;
while out == 0
figure(1)
    imshow (mask1), title('Actual threshold of the LM picture');
    hold on   
    button = questdlg('Are you agree with this segmentation?');
    switch button	
        case 'Yes'
            out = 1;  
        case 'No'
            figure(2), imhist(imageLM), title('Histogram of the LM picture');
            line([lowerlimitLM,lowerlimitLM],[0, 10000000],'LineWidth',2,'Color',[0 1 0]);
            line([upperlimitLM,upperlimitLM],[0, 10000000],'LineWidth',2,'Color',[0 1 0]);
            outlower = 0;
            while outlower == 0
                prompt = sprintf('Give the value of the lower threshold value. The old one was %d',lowerlimitLM);
                lowerlimitLM = INPUTDLG(prompt);
                lowerlimitLM = str2num(lowerlimitLM{1});
                figure(2), imhist(imageLM), title('Histogram the LM picture');
                line([lowerlimitLM,lowerlimitLM],[0, 10000000],'LineWidth',2,'Color',[1 1 0]);
                line([upperlimitLM,upperlimitLM],[0, 10000000],'LineWidth',2,'Color',[0 1 0]);
                buttonlower = questdlg('Do you want to change again the lower threshold value?','Confirmation','No');
                switch buttonlower
                    case 'Yes'
                        figure(2), imhist(imageLM), title('Histogram of the LM picture');
                        line([lowerlimitLM,lowerlimitLM],[0, 10000000],'LineWidth',2,'Color',[0 1 0]);
                        line([upperlimitLM,upperlimitLM],[0, 10000000],'LineWidth',2,'Color',[0 1 0]);
                        outlower = 0;
                    case 'No'
                        outlower = 1;
                end
            end
            outupper = 0;
            while outupper == 0
                prompt = sprintf('Give the value of the upper threshold value. The old one was %d',upperlimitLM);
                upperlimitLM = INPUTDLG(prompt);
                upperlimitLM = str2num(upperlimitLM{1});
                figure(2), imhist(imageLM), title('Histogram the LM picture');
                line([lowerlimitLM,lowerlimitLM],[0, 10000000],'LineWidth',2,'Color',[1 1 0]);
                line([upperlimitLM,upperlimitLM],[0, 10000000],'LineWidth',2,'Color',[1 0 0]);
                buttonupper = questdlg('Do you want to change again the upper threshold value?','Confirmation','No');
                switch buttonupper
                    case 'Yes'
                        figure(2), imhist(imageLM), title('Histogram of the LM picture');
                        line([lowerlimitLM,lowerlimitLM],[0, 10000000],'LineWidth',2,'Color',[1 1 0]);
                        line([upperlimitLM,upperlimitLM],[0, 10000000],'LineWidth',2,'Color',[0 1 0]);
                        outupper = 0;
                    case 'No'
                        outupper = 1;
                end
            end         
            outif = 1;
            while outif == 1
                if lowerlimitLM > upperlimitLM
                    h = helpdlg('!!!The lower value have to be smaller than the upper value!!!','Error');
                    uiwait(h);
                    figure(2), imhist(imageLM), title('Histogram of the LM picture');
                    line([lowerlimitLM,lowerlimitLM],[0, 10000000],'LineWidth',2,'Color',[1 1 0]);
                    line([upperlimitLM,upperlimitLM],[0, 10000000],'LineWidth',2,'Color',[1 0 0]);
                    outlower = 0;
                    while outlower == 0
                        prompt = sprintf('Give the value of the lower threshold value. The old one was %d',lowerlimitLM);
                        lowerlimitLM = INPUTDLG(prompt);
                        lowerlimitLM = str2num(lowerlimitLM{1});
                        figure(2), imhist(imageLM), title('Histogram of the LM picture');
                        line([lowerlimitLM,lowerlimitLM],[0, 10000000],'LineWidth',2,'Color',[1 1 0]);
                        line([upperlimitLM,upperlimitLM],[0, 10000000],'LineWidth',2,'Color',[0 1 0]);
                        buttonlower = questdlg('Do you want to change again the lower threshold value?','Confirmation','No');
                        switch buttonlower
                            case 'Yes'
                                figure(2), imhist(imageLM), title('Histogram of the LM picture');
                                line([lowerlimitLM,lowerlimitLM],[0, 10000000],'LineWidth',2,'Color',[0 1 0]);
                                line([upperlimitLM,upperlimitLM],[0, 10000000],'LineWidth',2,'Color',[0 1 0]);
                                outlower = 0;
                            case 'No'
                            outlower = 1;
                        end
                    end
                    outupper = 0;
                    while outupper == 0
                        prompt = sprintf('Give the value of the upper threshold value. The old one was %d',upperlimitLM);
                        upperlimitLM = INPUTDLG(prompt);
                        upperlimitLM = str2num(upperlimitLM{1});
                        figure(2), imhist(imageLM), title('Histogram of the LM picture');
                        line([lowerlimitLM,lowerlimitLM],[0, 10000000],'LineWidth',2,'Color',[1 1 0]);
                        line([upperlimitLM,upperlimitLM],[0, 10000000],'LineWidth',2,'Color',[1 0 0]);
                        buttonupper = questdlg('Do you want to change again the upper threshold value?','Confirmation','No');
                        switch buttonupper
                            case 'Yes'
                                figure(2), imhist(imageLM), title('Histogram of the LM picture');
                                line([lowerlimitLM,lowerlimitLM],[0, 10000000],'LineWidth',2,'Color',[1 1 0]);
                                line([upperlimitLM,upperlimitLM],[0, 10000000],'LineWidth',2,'Color',[0 1 0]);
                                outupper = 0;
                            case 'No'
                            outupper = 1;
                        end
                    end   
                    outif = 1;
                else
                    outif = 0;
                end
            end
            BW = imageLM < upperlimitLM & imageLM > lowerlimitLM;
            BW = ~BW;
            BW = fct_imageroi1(BW);
            se = strel('disk', 1);
            BWc = imclose(BW, se);
            BW2 = IMFILL(BWc,'holes');
            BW3 = bwareaopen(BW2,5000);
            mask1 = immultiply(BW,BW3);
            mask1 = (mask1>0);
            mask1 = fct_imageroi1(mask1);
            out = 0;
    end
    close all;
end

out = 0;
mask1th = mask1;
rotationLM = 0;
oldrotationLM = 0;
while out == 0
    figure(1)
    imshow (mask1th), title('Rotation');
    hold on   
    button = questdlg('Do you want to change the orientation of this picture?');
    switch button	
        case 'Yes'
            InputDialog={'By how many degrees do you want to change the orientation? A positiv degree value induce a counterclockwise rotation.'};
            Name='Rotation';
            NumLines=1;
            rotationLM = inputdlg(InputDialog,Name,NumLines);
            rotationLM = str2num(rotationLM{1});
            rotationLM = oldrotationLM + rotationLM;
            mask1th = imrotate(mask1,rotationLM);
            oldrotationLM = rotationLM;
            mask1th = fct_imageroi1(mask1th);
            out = 0;  
        case 'No'
            out = 1;
    end
    close (1);
end
mask1 = mask1th;
clear mask1th;
sizemask1 = size(mask1);
figure(1)
    imshow(mask1), title('Set the region of interest');
    hold on   
    h = helpdlg('choose the upper left corner of the "Region of Interest" rectangle','Rectangle 1st corner');
    uiwait(h);
    [ rx1,ry1 ] = ginput(1);
    line([rx1,sizemask1(2)],[ry1,ry1],'LineWidth',2,'Color',[1 0 0]);
    line([rx1,rx1],[ry1,sizemask1(1)],'LineWidth',2,'Color',[1 0 0]);
    h = helpdlg('choose lower right corner of the "Region of Interest" rectangle','Rectangle 2nd corner');
    uiwait(h);
    [ rx2,ry2 ] = ginput(1);
    close(1);
figure(1), imshow(mask1), title('Set the region of interest');
    line([rx1,rx2],[ry1,ry1],'LineWidth',2,'Color',[1 0 0]);
    line([rx2,rx2],[ry1,ry2],'LineWidth',2,'Color',[1 0 0]);
    line([rx1,rx2],[ry2,ry2],'LineWidth',2,'Color',[1 0 0]);
    line([rx1,rx1],[ry1,ry2],'LineWidth',2,'Color',[1 0 0]);
    pause(0.001);
detailmask1 = mask1(ry1:ry2,rx1:rx2);

%%%%%%%%% Changes the size of the ROI. The LM picture is set by default 
%%%%%%%%% to about 250 x 250 pixels %%%%%%%%%
 prompt = sprintf('The size of all images will be set to 62500 pixels (it correspond to 250x250 pixels)!');
 choice = questdlg(prompt,'Slide size','Accept','Change size','Accept');
    switch choice
        case 'Change size'
            InputDialog={'Give the new size:'};
            Name='Change size';
            NumLines=1;
            newsize = inputdlg(InputDialog,Name,NumLines);
            newsize = str2num(newsize{1});                 		
        case 'Accept'
            newsize = 62500;
    end
magnification1 = sqrt(newsize / (sizemask1(1) * sizemask1(2)));
detailmask1 = imresize(detailmask1,magnification1);
smallmask1 = imresize(mask1,magnification1);

%%%%%%%% Defines the beginning and the end of the SRXTM stack.
%%%%%%%% It also ask for the step between two pictures --> Should we take
%%%%%%%% the whole stack or not %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[filenamefirst, pathname, filenamelast, first...
        , last, counterfirst, counterlast] = fct_multiplefileopen;
InputDialog={'Give the step between two analysed images:'};
Name='Step';
NumLines=1;
step = inputdlg(InputDialog,Name,NumLines);
step = str2num(step{1});
filename = filenamefirst;

%%%%%%%% Definition of the best theshold for the SXRTM pictures %%%%%%%%%
   %%%%% Importation the first SRXTM picture %%%%%
imageSRXTM = imread([pathname filename]);
mask2 = fct_thresholdSRXTM244(imageSRXTM);
lowerlimit = min(min(imageSRXTM));
upperlimit = max(max(imageSRXTM));
whilecount = 0;
out = 0;
invert = 0;
close all;
while out == 0
figure(1)
    if whilecount == 0
        imshow (mask2), title('Automatic threshold of a SRXTM picture');
        prompt = 'The background color should be black and the tissues should be white. Should we invert the colors?';
        buttoninvert = questdlg(prompt,'Invert?','Invert','Keep colors','Keep colors');
        switch buttoninvert	
        case 'Invert'
            invert = 1;
            mask2 = ~mask2;
            mask2 = fct_imageroi1(mask2);
            close 1;
            figure(1)
            imshow (mask2), title('Manual threshold of a SRXTM picture');
        case 'Keep colors'
            invert = 0;
        end
    else
        imshow (mask2), title('Manual threshold of a SRXTM picture');
    end
    imshow (mask2);
    hold on   
    button = questdlg('Are you agree with this segmentation?');
    switch button	
        case 'Yes'
            out = 1;  
        case 'No'
            whilecount = 1;
            figure(2), imhist(imageSRXTM), title('Histogram of a SRXTM picture');
            line([lowerlimit,lowerlimit],[0, 10000000],'LineWidth',2,'Color',[0 1 0]);
            line([upperlimit,upperlimit],[0, 10000000],'LineWidth',2,'Color',[0 1 0]);
            outlower = 0;
            while outlower == 0
                prompt = sprintf('Give the value of the lower threshold value. The old one was %d',lowerlimit);
                lowerlimit = INPUTDLG(prompt);
                lowerlimit = str2num(lowerlimit{1});
                figure(2), imhist(imageSRXTM), title('Histogram of a SRXTM picture');
                line([lowerlimit,lowerlimit],[0, 10000000],'LineWidth',2,'Color',[1 1 0]);
                line([upperlimit,upperlimit],[0, 10000000],'LineWidth',2,'Color',[0 1 0]);
                buttonlower = questdlg('Do you want to change the lower threshold value?');
                switch buttonlower
                    case 'Yes'
                        figure(2), imhist(imageSRXTM), title('Histogram of a SRXTM picture');
                        line([lowerlimit,lowerlimit],[0, 10000000],'LineWidth',2,'Color',[0 1 0]);
                        line([upperlimit,upperlimit],[0, 10000000],'LineWidth',2,'Color',[0 1 0]);
                        outlower = 0;
                    case 'No'
                        outlower = 1;
                end
            end
            outupper = 0;
            while outupper == 0
                prompt = sprintf('Give the value of the upper threshold value. The old one was %d',upperlimit);
                upperlimit = INPUTDLG(prompt);
                upperlimit = str2num(upperlimit{1});
                figure(2), imhist(imageSRXTM), title('Histogram of a SRXTM picture');
                line([lowerlimit,lowerlimit],[0, 10000000],'LineWidth',2,'Color',[1 1 0]);
                line([upperlimit,upperlimit],[0, 10000000],'LineWidth',2,'Color',[1 0 0]);
                buttonupper = questdlg('Do you want to change the upper threshold value?');
                switch buttonupper
                    case 'Yes'
                        figure(2), imhist(imageSRXTM), title('Histogram of a SRXTM picture');
                        line([lowerlimit,lowerlimit],[0, 10000000],'LineWidth',2,'Color',[1 1 0]);
                        line([upperlimit,upperlimit],[0, 10000000],'LineWidth',2,'Color',[0 1 0]);
                        outupper = 0;
                    case 'No'
                        outupper = 1;
                end
            end         
            outif = 1;
            while outif == 1
                if lowerlimit > upperlimit
                    h = helpdlg('!!!The lower value have to be smaller than the upper value!!!','Error');
                    uiwait(h);
                    figure(2), imhist(imageSRXTM), title('Histogram of a SRXTM picture');
                    line([lowerlimit,lowerlimit],[0, 10000000],'LineWidth',2,'Color',[1 1 0]);
                    line([upperlimit,upperlimit],[0, 10000000],'LineWidth',2,'Color',[1 0 0]);
                    outlower = 0;
                    while outlower == 0
                        prompt = sprintf('Give the value of the lower threshold value. The old one was %d',lowerlimit);
                        lowerlimit = INPUTDLG(prompt);
                        lowerlimit = str2num(lowerlimit{1});
                        figure(2), imhist(imageSRXTM), title('Histogram of a SRXTM picture');
                        line([lowerlimit,lowerlimit],[0, 10000000],'LineWidth',2,'Color',[1 1 0]);
                        line([upperlimit,upperlimit],[0, 10000000],'LineWidth',2,'Color',[0 1 0]);
                        buttonlower = questdlg('Do you want to change the lower threshold value?');
                        switch buttonlower
                            case 'Yes'
                                figure(2), imhist(imageSRXTM), title('Histogram of a SRXTM picture');
                                line([lowerlimit,lowerlimit],[0, 10000000],'LineWidth',2,'Color',[0 1 0]);
                                line([upperlimit,upperlimit],[0, 10000000],'LineWidth',2,'Color',[0 1 0]);
                                outlower = 0;
                            case 'No'
                            outlower = 1;
                        end
                    end
                    outupper = 0;
                    while outupper == 0
                        prompt = sprintf('Give the value of the upper threshold value. The old one was %d',upperlimit);
                        upperlimit = INPUTDLG(prompt);
                        upperlimit = str2num(upperlimit{1});
                        figure(2), imhist(imageSRXTM), title('Histogram of a SRXTM picture');
                        line([lowerlimit,lowerlimit],[0, 10000000],'LineWidth',2,'Color',[1 1 0]);
                        line([upperlimit,upperlimit],[0, 10000000],'LineWidth',2,'Color',[1 0 0]);
                        buttonupper = questdlg('Do you want to change the upper threshold value?');
                        switch buttonupper
                            case 'Yes'
                                figure(2), imhist(imageSRXTM), title('Histogram of a SRXTM picture');
                                line([lowerlimit,lowerlimit],[0, 10000000],'LineWidth',2,'Color',[1 1 0]);
                                line([upperlimit,upperlimit],[0, 10000000],'LineWidth',2,'Color',[0 1 0]);
                                outupper = 0;
                            case 'No'
                            outupper = 1;
                        end
                    end   
                    outif = 1;
                else
                    outif = 0;
                end
            end
            BW = imageSRXTM < upperlimit & imageSRXTM > lowerlimit;
            if invert == 1
                BW = ~BW;
            else
                close 1;
                figure(1)
                imshow (mask2), title('Manual threshold of a SRXTM picture');
                prompt = 'The background color should be black and the tissues should be white. Should we invert the colors?';
                buttoninvert = questdlg(prompt,'Invert?','Invert','Keep colors','Keep colors');
                switch buttoninvert	
                    case 'Invert'
                        invert = 1;
                    case 'Keep colors'
                        invert = 0;
                end
            end
            BW = fct_imageroi1(BW);
            se = strel('disk', 1);
            BWc = imclose(BW, se);
            BW2 = IMFILL(BWc,'holes');
            BW3 = bwareaopen(BW2,5000);
            mask2 = immultiply(BW,BW3);
            mask2 = (mask2>0);
            mask2 = fct_imageroi1(mask2);
            out = 0;
    end
    close all;
end

out = 0;
actualpicture = first;
rotanglemask2 = 0;
while out == 0
    figure(1)
    subplot(2,1,1)
        imshow(smallmask1,[])
        title ('LM');
	subplot(2,1,2)
        imshow(mask2,[])
        title ('SRXTM');
    hold on   
    button = questdlg('Should we take this SRXTM picture for the orientation?');
    switch button	
        case 'Yes'
            while out == 0
                prompt = sprintf('By how many degrees should the SRXTM picture be rotate to have the same orientation as the LM picture. The tolerance in the orientation between the two images should be +/- 15°. Positive rotation is counterclockwise');
                handangle = INPUTDLG(prompt);
                handangle = str2num( handangle{1});
                mask2 = imrotate(mask2,handangle);
                mask2 = fct_imageroi1(mask2);
                rotanglemask2 = rotanglemask2 + handangle;
                close all;
                figure(2)
                subplot(2,1,1)
                    imshow(smallmask1,[])
                    title ('LM');
                subplot(2,1,2)
                    imshow(mask2,[])
                    title ('SRXTM');
                prompt = sprintf('Do you accept this orientation of the SRXTM picture?');
                choice = questdlg(prompt,'Choose slices','Accept','New rotation','Accept');
                switch choice
                    case 'Accept'
                        if actualpicture > first
                            prompt = sprintf('Should we change the first image in the SRXTM stack from %4d to %4d',first,actualpicture);
                            button2 = questdlg(prompt);
                            switch button2
                                case 'Yes'
                                    first = actualpicture;
                                case 'No'
                            end
                        end
                        out = 1;    		
                    case 'New rotation'
                        out = 0;
                end
            end    
        case 'No'
            prompt = sprintf('The actual SRXTM picture is: Slide %4d. Enter a new slide between %4d and %4d',... 
                actualpicture,first,last);
            actualpicture = INPUTDLG(prompt);
            actualpicture = str2num( actualpicture{1});
            while  (actualpicture < first) || (actualpicture > last)
                prompt = sprintf('Enter a slide number BETWEEN %4d AND %4d',first,last);
                actualpicture = INPUTDLG(prompt);
                actualpicture = str2num( actualpicture{1});
            end 
            filename(counterfirst:counterlast) = sprintf('%04d',actualpicture)
            imageSRXTM = imread([pathname filename]);
            if whilecount == 0
                mask2 = fct_thresholdSRXTM244(imageSRXTM);
            else
                BW = imageSRXTM < upperlimit & imageSRXTM > lowerlimit;
                BW = fct_imageroi1(BW);
                se = strel('disk', 1);
                BWc = imclose(BW, se);
                BW2 = IMFILL(BWc,'holes');
                BW3 = bwareaopen(BW2,5000);
                mask2 = immultiply(BW,BW3);
                mask2 = (mask2>0);
                mask2 = fct_imageroi1(mask2);
            end
            out = 0
    end
    close all;
end

%%%%%%%%%%%%%%%%%%%%%%  Automatic setting of the orientation based on the correlation   %%%%%%%%%%%%%%%%%%%%
filename = filenamefirst;
maxbar1 = (last - first) / step;
countbar1 = 0;
LoopCount = 0;
h = waitbar(0,'Please wait... Correlation is in process');
for p=first:step:last 
    waitbar(countbar1 / maxbar1,h)
    countbar1 = countbar1 + 1;
    LoopCount = LoopCount + 1
    filename(counterfirst:counterlast) = sprintf('%04d', p)
    outerror = 0;
    while outerror == 0
        fid = fopen([pathname filename], 'r');
        if (fid == -1)
            p = p + 1;
            filename(counterfirst:counterlast) = sprintf('%04d', p)
        else
            outerror = 1;
        end
    end     
    imageSRXTM = imread([pathname filename]);
    if whilecount == 0
        [mask2] = fct_thresholdSRXTM244(imageSRXTM);
        mask2 = fct_imageroi1(mask2);
    else
        BW = imageSRXTM < upperlimit & imageSRXTM > lowerlimit;
        BW = fct_imageroi1(BW);
        se = strel('disk', 1);
        BWc = imclose(BW, se);
        BW2 = IMFILL(BWc,'holes');
        BW3 = bwareaopen(BW2,5000);
        mask2 = immultiply(BW,BW3);
        mask2 = (mask2>0);
        mask2 = fct_imageroi1(mask2);
    end
mask2 = imrotate (mask2,rotanglemask2);
sizemask2 = size(mask2);
magnification2 = sqrt(newsize / (sizemask2(1) * sizemask2(2)));
detailmask2 = imresize(mask2,magnification2);

correlation = 0;
    for i =  -25 : 2 : 25
        rotmask2 = imrotate(detailmask2,i);
        rotmask2 = fct_imageroi1(rotmask2);
        c = normxcorr2(detailmask1,rotmask2);
        correlationstep = max(max(c));
        if correlationstep > correlation
            correlation = correlationstep;
            position = i;
       end
    end
anglerot = position;
correlation = 0;
    for i = anglerot - 5 : 0.5 : anglerot + 5
        rotmask2 = imrotate(detailmask2,i);
        rotmask2 = fct_imageroi1(rotmask2);
        c = normxcorr2(detailmask1,rotmask2);
        correlationstep = max(max(c));
        if correlationstep > correlation
            correlation = correlationstep;
            rotation = i;
       end
    end
 vectorrot(p) = rotation;
 vectcorrelation(p) = correlation;
 vectorposition(p) = p;    
end

%%%%%%%% The vectors (vectcorrelation(p) & vectorposition(p)) contain many
%%%%%%%% zero entries if p is not begining at 0. So this for loop eliminate
%%%%%%%% all zero entries thank the if statement %%%%%%%%%%%%%%%%%%%%%%%%%
sizevectcorr = size(vectcorrelation);
countcorr = 1;
for o = 1:sizevectcorr(2)
    if vectcorrelation(o) ~= 0
        vectcorrelation2(countcorr) = vectcorrelation(o);
        vectorposition2(countcorr) = vectorposition(o);
        countcorr = countcorr + 1;
    end
end

%%%%%%%% Find the best correlation and slice %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bestcorr = 0;
sizevectcorr = size(vectcorrelation2);
for o = 1:sizevectcorr(2)
    if vectcorrelation2(o) > bestcorr
       bestcorr = vectcorrelation2(o);
       bestcorrplace = vectorposition2(o);
    end
end
percentcorr = 5;
sizepos = size(vectorposition2);
limitcorr(1 : sizepos(2)) = bestcorr - (bestcorr /100) * percentcorr;
figure(1), plot(vectorposition2,vectcorrelation2,'b.-');


%%%%%%%% Desision if fine searching or not %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
prompt = sprintf('Do you want to proceed a fine searching in the SRXTM stack of images?');
button = questdlg(prompt,'Fine searching');
switch button	
    case 'Yes'
        outif = 0;   
    case 'No'
        outif = 1;
end

%%%%%%%% This if contain the whole fine searching. If we want not do the
%%%%%%%% fine searching, then the "outif" is set to 0 %%%%%%%%%%%%%%%%%%%%
if outif == 0
    
    %%%%%%%% Set a limit at 5% (this limit can be changed) of the best
    %%%%%%%% correlation and plot all correlation's result %%%%%%%%%%%%%%%
    out = 0;
    while out == 0;
        figure(7), plot(vectorposition2,vectcorrelation2,'b.-',...
        vectorposition2,limitcorr,'r -');
        prompt = sprintf('Are you agree with this limit of %d percent?',percentcorr);
        button = questdlg(prompt,'Set limit');
        switch button	
            case 'Yes'
                out = 1; 
            case 'No'
                prompt = sprintf('Give a value between 0 and 100 for the new limit. The last one was %d percent',percentcorr);
                percentcorr = INPUTDLG(prompt);
                percentcorr = str2num(percentcorr{1});
                outif = 0;
                while outif == 0
                if percentcorr > 100 || percentcorr < 0
                    prompt = sprintf('Give a value BETWEEN 0 AND 100 for the new limit. The last one was %d percent',percentcorr);
                    percentcorr = INPUTDLG(prompt);
                    percentcorr = str2num(percentcorr{1});
                    outif = 0;
                else
                    outif = 1;
                end
                end
                limitcorr(1 : sizepos(2)) = bestcorr - (bestcorr /100) * percentcorr;
        end
    end

%%%%%%%% Choosing of the regions who have to be analyzed in the fine search
    %%%%%%%% (fine tuning) part of the program %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    clear prompt;
    sizevectpos2 = size(vectorposition2);
    countervector = 0;
    firstprompt = 1;
    for o = 1:sizevectpos2(2)
    if vectcorrelation2(o) > limitcorr(1)
       countervector = countervector + 1;
       vectorslide(countervector) = vectorposition2(o);
       prompt(firstprompt:firstprompt + 4) = sprintf(',%04d',vectorposition2(o));
       sizeprompt = size(prompt);
       firstprompt =  sizeprompt(2) + 1;
    end
    end

    prompt = prompt(2:sizeprompt(2));
    prompt = sprintf('The matches upper the limit are: Slices{%s}. Should we take all of them for the fine correlation?',prompt);
    button = questdlg(prompt);
    sizevectorslide = size(vectorslide);
    switch button	
        case 'Yes'   
            vectorslide2 =  vectorslide;
        case 'No'
            stackcounter = 1;
            for n = 1:sizevectorslide(2)
            prompt = sprintf('Should the slice : %04d be a part of the fine tuning stack?'...
                    ,vectorslide(n));
            choice = questdlg(prompt,'Choose slices','Accept','Refuse','Accept');
            switch choice
                case 'Accept'
                    vectorslide2(stackcounter) =  vectorslide(n); 
                    stackcounter = stackcounter + 1;    		
                 case 'Refuse'
                        
            end
            end
    end
    
    LoopCount2 = 0;
    sizevectslide2 = size(vectorslide2);
    vectcorrelationfine (1:last) = 0;
    maxbar = (sizevectslide2(2) * 2 * step) * 72;
    countbar = 1;
    h = waitbar(0,'Please wait... Fine correlation in process');
    for u = 1 : sizevectslide2(2)
        for f = round(vectorslide2(u) - step) : round(vectorslide2(u) + step)
            LoopCount2 = LoopCount2 + 1
            countbar
            if f > last
                f = last;
            end
            if f < first
                f = first;
            end
            if  vectcorrelationfine(f) == 0
                filename(counterfirst:counterlast) = sprintf('%04d', f)
                outerror = 0;
                while outerror == 0
                    fid = fopen([pathname filename], 'r');
                    if (fid == -1)
                        p = p + 1;
                        filename(counterfirst:counterlast) = sprintf('%04d', p)
                    else
                    outerror = 1;
                    end
                end     
                imageSRXTM = imread([pathname filename]);
                if whilecount == 0
                    [mask2] = fct_thresholdSRXTM244(imageSRXTM);
                    mask2 = fct_imageroi1(mask2);
                else
                    BW = imageSRXTM < upperlimit & imageSRXTM > lowerlimit;
                    BW = fct_imageroi1(BW);
                    se = strel('disk', 1);
                    BWc = imclose(BW, se);
                    BW2 = IMFILL(BWc,'holes');
                    BW3 = bwareaopen(BW2,5000);
                    mask2 = immultiply(BW,BW3);
                    mask2 = (mask2>0);
                    mask2 = fct_imageroi1(mask2);
                end  
                correlation2 = 0;
                sizemask2 = size(mask2);
                magnification2 = sqrt(newsize / (sizemask2(1) * sizemask2(2)));
                detailmask2 = imresize(mask2,magnification2);
                correlation = 0;
                for i =  (vectorrot(f) - 25) : 1 : (vectorrot(f) + 25)
                    waitbar(countbar / maxbar)
                    countbar = countbar + 1;
                    rotmask2 = imrotate(detailmask2,i);
                    rotmask2 = fct_imageroi1(rotmask2);
                    c = normxcorr2(detailmask1,rotmask2);
                    correlationstep = max(max(c));
                    if correlationstep > correlation
                        correlation = correlationstep;
                        position = i;
                    end
                end
                
                anglerot = position;
                correlation = 0;
                for i = anglerot - 5 : 0.5 : anglerot + 5
                    waitbar(countbar / maxbar)
                    countbar = countbar + 1;
                    rotmask2 = imrotate(detailmask2,i);
                    rotmask2 = fct_imageroi1(rotmask2);
                    c = normxcorr2(detailmask1,rotmask2);
                    correlationstep = max(max(c));
                    if correlationstep > correlation
                        correlation = correlationstep;
                        rotation = i;
                    end
                end
                vectorrotfine(f) = rotation;
                vectcorrelationfine(f) = correlation;
                vectorpositionfine(f) = f;   
            else
                countbar = countbar + 72;
            end
         end
    end
    close all;
    
    %%%%%%%% The vectors (vectcorrelation(p) & vectorposition(p)) contain many
    %%%%%%%% zero entries if p is not begining at 0. So this for loop eliminate
    %%%%%%%% all zero entries thank the if statement %%%%%%%%%%%%%%%%%%%%%%%%%
    sizevectcorrfine = size(vectcorrelationfine);
    countcorr = 1;
    for o = 1:sizevectcorrfine(2)
        if vectcorrelationfine(o) ~= 0
            vectcorrelationfine2(countcorr) = vectcorrelationfine(o);
            vectorpositionfine2(countcorr) = vectorpositionfine(o);
            bestangle2(countcorr) = vectorrotfine(o);
            countcorr = countcorr + 1;
        end
    end
    
    bestcorr = 0;
    sizevectcorrfine = size(vectcorrelationfine2);
    for o = 1:sizevectcorrfine(2)
        if vectcorrelationfine2(o) > bestcorr
            bestcorr = vectcorrelationfine2(o);
            bestcorrplace = vectorpositionfine2(o);
            bestrotation = bestangle2(o);
        end
    end
    figure(1), plot(vectorpositionfine2,vectcorrelationfine2,'b.-');
else
    vectorrotfine = vectorrot; 
end
 
filename(counterfirst:counterlast) = sprintf('%04d', bestcorrplace)
imageBest = imread([pathname filename]);
bestcorr
prompt = sprintf('Best correlation : %s',filename);
figure(2), imshow(imageBest), title(prompt,'Interpreter','none');


if whilecount == 0
    mask2 = fct_thresholdSRXTM244(imageBest);
else
    BW = imageSRXTM < upperlimit & imageSRXTM > lowerlimit;
    BW = fct_imageroi1(BW);
    if invert == 1
        BW = ~BW;
    end
    se = strel('disk', 1);
    BWc = imclose(BW, se);
    BW2 = IMFILL(BWc,'holes');
    BW3 = bwareaopen(BW2,5000);
    mask2 = immultiply(BW,BW3);
    mask2 = (mask2>0);
    mask2 = fct_imageroi1(mask2);
end  
sizemask2 = size(mask2);
detailmask2 = mask2;
magnification1 = sqrt(3000000 / (sizemask1(1) * sizemask1(2)));
detailmask1 = mask1(ry1:ry2,rx1:rx2);
detailmask1 = imresize(detailmask1,magnification1);
detailmask2 = imrotate(detailmask2,vectorrotfine(bestcorrplace));
detailmask2 = fct_imageroi1(detailmask2);
sizemask2 = size(detailmask2);
magnification2 = sqrt(3000000 / (sizemask2(1) * sizemask2(2)));
detailmask2 = imresize(detailmask2,magnification2);
c = normxcorr2(detailmask1,detailmask2);

[max_c, imax] = max(abs(c(:)));
[ypeak, xpeak] = ind2sub(size(c),imax(1));
corr_offset = [abs(xpeak-size(detailmask1,2))
               abs(ypeak-size(detailmask1,1))];
offset = corr_offset;
xoffset = offset(1);
yoffset = offset(2);
xbegin = round(xoffset)+1;
xend   = round(xoffset+ size(detailmask1,2));
ybegin = round(yoffset)+1;
yend   = round(yoffset+size(detailmask1,1));
coldetailmask2 = detailmask2 * 20;
coldetailmask2 = uint16(coldetailmask2);
coldetailmask2 = double(coldetailmask2);
coldetailmask1 = detailmask1 * 40;
coldetailmask1 = uint16(coldetailmask1);
coldetailmask1 = double(coldetailmask1);
coldetailmask2(ybegin:yend,xbegin:xend) = imadd(coldetailmask2(ybegin:yend,xbegin:xend),coldetailmask1);
figure
image(coldetailmask2);
axis off          
axis image







