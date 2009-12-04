function [mask2,level] = fct_thresholdSRXTMLevel(picture)

level = graythresh(picture);
BW = im2bw(picture, level);
%[pixelH pixelV] = size(BW);
%sizefactor = 2500e003 / (pixelH * pixelV);
%BW = imresize(BW,sizefactor);
%controlif3a = 0
se = strel('disk', 4);
%controlif3b = 0
BWc = imclose(BW, se);
%controlif3c = 0
BW2 = IMFILL(BWc,'holes');
%controlif3d = 0
BW3 = bwareaopen(BW2,100);
%controlif3e = 0
mask2 = immultiply(BW,BW3);
%controlif3f = 0
mask2 = (mask2>0);
%mask2 = fct_imageroi1(mask2);
%controlif3g = 0

end