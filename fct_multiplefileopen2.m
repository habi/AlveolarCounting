function [filenamefirst, pathname,filenamelast,first...
        ,last,counterfirst,counterlast] = fct_multiplefileopen2

%%% Ask the path of the first image of the SRXTM stack
    [ filenamefirst, pathname1] = ...
        uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
            '*.*','All Files' },...
        'Give the first image of the stack you want to analyze'); 
  
%%% Ask the path of the last image of the SRXTM stack  

    b = size(filenamefirst);
    Name = sprintf('Give the last image of the stack you want to analyze. The first image is : %s',filenamefirst);
    [ filenamelast, pathname] = ...
        uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
            '*.*','All Files' }, Name,pathname1);
    
    
%%% Search the variable part of the file names 
    filename = filenamefirst;
    A = abs(filenamelast - filenamefirst);
    A = find(A>0 | A<0);
    B = filenamelast;
    B = find(B>47 & B<58);
    [j sizeb] = size(B);
   
    counter = 1;
    while A(1)~= B(counter) & counter <= sizeb
        counter = counter + 1;
    end
  
    counter2 = 1;
    out = 0;
    while out == 0
        if (counter - counter2) > 1
            if B(counter - counter2) == B(counter)- counter2
                counter2 = counter2 + 1;
            else
                counter2 = counter2 - 1;
                out = 1;
            end
        else
           counter2 = counter2 - 1;
           out = 1;
        end
    end
    
    
    counter3 = 1;
    out = 0;
    while out == 0
        if (counter + counter3) <= sizeb
            if B(counter + counter3) == B(counter) + counter3 
                counter3 = counter3 + 1;
            else
                out = 1;
            end
        else
            counter3 = counter3 - 1;
            out = 1;
        end
    end
  
%%% Find out the number of the first and last image in the choosen stack    
    first = 0;
    last = 0;
    for h = counter - counter2 : counter + counter3
        first = (first) * 10 + filenamefirst(B(h)) - 48; 
        last = (last) * 10 + filenamelast(B(h)) - 48;
        filename(B(h)) = 48;
    end
  
   
    counterfirst = B(counter - counter2);
    counterlast =  B(counter + counter3);
    
end