%% EE425/EE453 Assignment Part 3
%
% part3.m
%%
clear all
clc
close all

%read in the image
tie = openimage('tie.jpg');
%convert to grayscale
tiegrey=vsg('GreyScaler',tie);
[hi_g]=vsg('HighestGrey',tiegrey);
[lo_g]=vsg('LowestGrey',tiegrey);
threshtie=uint8((hi_g+lo_g)/2);
[out_img3]=vsg('Threshold',tiegrey,threshtie);

% read in the image
Template = openimage('template_tie.jpg');
% convert to greyscale
tempgrey=vsg('GreyScaler',Template);
[hi_g2]=vsg('HighestGrey',tempgrey);
[lo_g2]=vsg('LowestGrey',tempgrey);
threshtemp=uint8((hi_g2+lo_g2)/2);
[out_img4]=vsg('Threshold',tempgrey,threshtemp);


[out_img5]=vsg('Convolution',out_img3,out_img4);
% threshold for convolution of given tie temp
threshhi = vsg('HighestGrey',out_img5);
threshlo=vsg('LowestGrey',out_img5);
thresh=uint8((threshhi+threshlo)/2);


[out_img6]=vsg('Threshold',out_img5,thresh);
[out_img8]=vsg('Centroid',out_img6);
detect_bw = im2bw(out_img8);
[x, y] = find(detect_bw == 1);
image_output = tie;

for i=1:length(x)
    image_output = vsg('DrawCircle',image_output,[y(i,1),x(i,1)],35, [255,0,0],4);
end
% Display the image
h=figure; image(uint8(image_output)); colormap(gray); set(h,'Name','Grey scale convolution');axis image;

%% part 3 d Gaussian noise
Template2 = vsg('GaussianNoise',Template,73);
%find threshold of template
tempgrey2=vsg('GreyScaler',Template2);
[hi_g2]=vsg('HighestGrey',tempgrey2);
[lo_g2]=vsg('LowestGrey',tempgrey2);
threshtemp2=uint8((hi_g2+lo_g2)/2);
[out_img3d]=vsg('Threshold',tempgrey2,threshtemp2);

%convolve template and tie images using thrshhold images
[out_img5d]=vsg('Convolution',out_img3,out_img3d);
%threshold result of convolution 
threshhi3d = vsg('HighestGrey',out_img5d);
threshlo3d=vsg('LowestGrey',out_img5d);
thresh=uint8((threshhi3d+threshlo3d)/2);
[out_img6d]=vsg('Threshold',out_img5d,thresh);

[out_img8d]=vsg('Centroid',out_img6d);
detect_bwd = im2bw(out_img8d);
[xd, yd] = find(detect_bwd == 1);
image_outputd = tie;

for i=1:length(xd)
    image_outputd = vsg('DrawCircle',image_outputd,[yd(i,1),xd(i,1)],35, [255,120,0],4);
end
% Display the image
h=figure; image(uint8(image_outputd)); colormap(gray); set(h,'Name','Convolution with noise image template');axis image;
h=figure; image(uint8(Template2)); colormap(gray); set(h,'Name','Noise image');axis image;
h=figure; image(uint8(out_img3d)); colormap(gray); set(h,'Name','Threshold of Noise image');axis image;


%% part 3 e
tietemp270 = vsg('RotateImg',out_img4,270);


[out_img10]=vsg('Convolution',out_img3,tietemp270);

threshhi2 = vsg('HighestGrey',out_img10);
threshlo2=vsg('LowestGrey',out_img10);
thresh2=uint8((threshhi2+threshlo2)/2);

[out_img11]=vsg('Threshold',out_img10,thresh2);
[out_img12]=vsg('Centroid',out_img11);
detect_bw2 = im2bw(out_img12);

[x2, y2] = find(detect_bw2 == 1);
image_output2 = image_output;

for i=1:length(x2)
    image_output2 = vsg('DrawCircle',image_output2,[y2(i,1),x2(i,1)],35, [255,255,0],4);
end
% Display the image
h=figure; image(uint8(image_output2)); colormap(gray); set(h,'Name','Enhanced programme');axis image;
