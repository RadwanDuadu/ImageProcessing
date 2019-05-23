clear all
clc
close all

% images calculator calc2 calc1
image = imread('tt.tif');
%
[out_img1]=vsg('ScaleImg',image,1134,1360);

grey = vsg('GreyScaler',out_img1);
% adding noise
grey2 =vsg('GaussianNoise',grey,0);

%chnage image to binary and filter noise
[hi_g]=vsg('HighestGrey',grey2);
[lo_g]=vsg('LowestGrey',grey2);
thresh=uint8((hi_g+lo_g)/2);
BW1=vsg('Threshold',grey2,thresh);

image2 =vsg('Open',BW1,8);

%erossion using structuring elements 
marker = imerode(image2, strel('line',4,0));
Iclean = imreconstruct(marker, image2);

marker2 = imerode(Iclean, strel('line',10,90));
Iclean2 = imreconstruct(marker2, Iclean);
BW3 = Iclean2;

% display input and output image
figure;
imshowpair(grey2, BW3, 'montage');
%% part c

% orginal image otsu threshold
org = multithresh(image);


% getting output reconstructed image
test= imreconstruct(image2, grey2);
markerc = imerode(test, strel('line',7,0));
Icleanc = imreconstruct(markerc, test);
markerc2 = imerode(Icleanc, strel('line',10,90));
Icleanc2 = imreconstruct(markerc2, Icleanc);
final= multithresh(Icleanc2);

% change the images to binary
BW = imquantize(image,org);
BW2 = imquantize(Icleanc2,final);

%display result
figure;
imshowpair(BW,BW2,'montage');

