%% automatically load a colour image & then convert to grey scale

addpath('C:\VSG_IPA_toolbox');

% clear workspace and free up system memory.
clc;                    % Clear command window.
clear all;              % Clear all variables and functions from memory

% Load an image 
% Convolution example

% read in the image
%in_img1=openimage('C:\VSG_IPA_toolbox\images\texteg.bmp');
in_img1=openimage('letters.jpg');
% Define the N-tuple to be used
input1 = imread('template_T.jpg');
input2 = imread('template_L.jpg');
%conv_arr=zeros(11,11);
%conv_arr(2:10,4:5)=1;
%conv_arr(4,2:9)=1;
%conv_arr(11,5:9)=1;
conv_arr= vsg('NOT',input1);
conv_arr2= vsg('NOT',input2);

% Convert to white text on a black background
[out_img1]=vsg('MidThresh',in_img1);
[out_img2]=vsg('NOT',out_img1);

% Convolve the text image with the N-tuple
[out_img3]=vsg('Convolution',out_img2,conv_arr);
[out_img12]=vsg('Convolution',out_img2,conv_arr2);
% Threshold the result of the convolution. A high output from the
% convolution indicates that the N-tuple is very similar to the region in
% the input image at the location of the high response.
thresh=210;
[out_img4]=vsg('Threshold',out_img3,thresh);
thresh2=235;
[out_img13]=vsg('Threshold',out_img12,thresh2);
[out_imgadd]=vsg('Add',out_img13,out_img4);
% Draw a square at each location that the response of the convolution was
% greater than the threshold, and display the squares on the white text on
% black background image.
[out_img5]=vsg('Point2Square',out_img4);
[test] = vsg('NOT',out_img5);
greyvalue=255;
[out_img6]=vsg('BinGrey',out_img2,greyvalue);
[out_img7]=vsg('Add',test,out_img6);
[out_img8]=vsg('NOT',out_img7);
%[out_img9]=vsg('Add',out_img8,in_img1);


% Display the images
h=figure; image(uint8(in_img1)); colormap(gray); set(h,'Name','Input');axis image;
h=figure; imagesc(uint8(conv_arr)); colormap(gray); set(h,'Name','Convolution Kernel');axis image;
h=figure; image(uint8(out_img4)); colormap(gray); set(h,'Name','Letter Locations');axis image;
h=figure; image(uint8(out_img7)); colormap(gray); set(h,'Name','Highlighted text');axis image;
h=figure; image(uint8(out_imgadd)); colormap(gray); set(h,'Name','exp');axis image;
