%% EE425/EE453 Assignment Part 1
%
% Edge_Detection.m
%
%% automatically load a colour image & then convert to grey scale

addpath('C:\VSG_IPA_toolbox');

% clear workspace and free up system memory.
clc;                    % Clear command window.
clear all;              % Clear all variables and functions from memory

% Load an image 
img1 = imread('stokes_building.jpg') ;

% convert to greyscale
img2=rgb2gray(img1);

% display the results 
figure('Name','input images','NumberTitle','off'),
subplot(1,2,1); imshow(img1), title('colour image'),
subplot(1,2,2); imshow(img2), title('greyscale image');
%% Edge detection using robert & sobel methods

% finding edge's using robert's method
roberts = edge(img2,'Roberts');
% finding edge's using sobel's method
sobel = edge(img2,'Sobel');

%display results vs grey scale image
h=figure,imshow(roberts), title('roberts method'),
h=figure,imshow(sobel), title('sobel method');
%% calc images with noise 

% noise @ 15
roberts15 = vsg('GaussianNoise',roberts,0.15);
sobels15 = vsg('GaussianNoise',sobel,0.15);


% noise @ 10
roberts10 = vsg('GaussianNoise',roberts,0.1);
sobels10 = vsg('GaussianNoise',sobel,0.1);

% noise @ 5
roberts5 = vsg('GaussianNoise',roberts,0.05);
sobels5 = vsg('GaussianNoise',sobel,0.05);

% noise @ 2
roberts2 = vsg('GaussianNoise',roberts,0.02);
sobels2 = vsg('GaussianNoise',sobel,0.02);

%% Guass noise @2
h=figure; imshow(roberts2), title('roberts method + 2% noise'),
h=figure; imshow(sobels2), title('sobel method + 2% noise');

%% Guass noise @5 
h=figure; imshow(roberts5), title('roberts method + 5% noise'),
h=figure; imshow(sobels5), title('sobel method + 5% noise');

%% Guass noise @10
h=figure; imshow(roberts10), title('roberts method + 10% noise'),
h=figure; imshow(sobels10), title('sobel method + 10% noise');

%% Guass noise @15 
h=figure; imshow(roberts15), title('roberts method + 15% noise'),
h=figure; imshow(sobels15), title('sobel method + 15% noise');
%% rotating the images

 grey30 = vsg('RotateImg',img2,30);
 grey90 = vsg('RotateImg',img2,90);
 grey180 = vsg('RotateImg',img2,180);
 grey210 = vsg('RotateImg',img2,210);
 grey330 = vsg('RotateImg',img2,330);

 robertsA30  = edge(grey30,'Roberts');
 robertsA90  = edge(grey90,'Roberts');
 robertsA180 = edge(grey180,'Roberts');
 robertsA210 = edge(grey210,'Roberts');
 robertsA330 = edge(grey330,'Roberts');
 
 sobelsA30  = edge(grey30,'Sobel');
 sobelsA90  = edge(grey90,'Sobel');
 sobelsA180 = edge(grey180,'Sobel');
 sobelsA210 = edge(grey210,'Sobel');
 sobelsA330 = edge(grey330,'Sobel');
 
 %% angle @30
h=figure; imshow(roberts), title('roberts image'),
h=figure; imshow(robertsA30), title('roberts method + 30 degrees'),
h=figure; imshow(sobel), title('sobel image'),
h=figure; imshow(sobelsA30), title('sobel method + 30 degrees');
 %% angle @90
h=figure; imshow(robertsA90), title('roberts method @ 90 degrees'),
h=figure; imshow(sobelsA90), title('sobel method @ 90 degrees');
%% angle @ 210
h=figure; imshow(robertsA210), title('roberts method @ 210 degrees'),
h=figure; imshow(sobelsA210), title('sobel method @ 210 degrees');
%% angle @330
h=figure; imshow(robertsA330), title('roberts method @ 330 degrees'),
h=figure; imshow(sobelsA330), title('sobel method @ 330 degrees');



  