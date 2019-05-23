%% EE425/EE453 Assignment 
%
% threshold_example.m
%
% Sample code to demonstrate the threshold operation
%
% Copyright 2016 Paul F Whelan

%% Set-up MATLAB paths and load data

addpath('C:\VSG_IPA_toolbox');

% clear workspace and free up system memory.
clc;                    % Clear command window.
clear all;              % Clear all variables and functions from memory

% Load an image 
img1 = imread('face.jpg') ;

% convert to greyscale
img2=rgb2gray(img1);

% display the results 
figure('Name','input images','NumberTitle','off'),
subplot(1,2,1); imshow(img1), title('colour image'),
subplot(1,2,2); imshow(img2), title('greyscale image');

%% contrast enhancement 
% apply contrast enhancement and examine its effect on the grey
% level distribution

img3=vsg('Enhancer',img2);

% cast the display images to unsigned integer (ie range 0-255)
figure('Name','contrast enhancement','NumberTitle','off'),
subplot(2,2,1); imshow(uint8(img2)), title('greyscale image'),
subplot(2,2,2); imhist(uint8(img2)), title('histogram'),
subplot(2,2,3); imshow(uint8(img3)), title('contrast enhanced image'),
subplot(2,2,4); imhist(uint8(img3)), title('contrast enhanced histogram');

%% fixed thresholding
% apply a fixed threshold of 150 to the original image to produce a binary image

threshold_value=150;
img4=vsg('Threshold',img2,threshold_value);

figure('Name','fixed threshold','NumberTitle','off'),
subplot(1,2,1); imshow(uint8(img2)), title('Greyscale Input image'),
subplot(1,2,2); imshow(uint8(img4)), title('Threshold image');

%% wait for "any key input" before deleting all figures
% Note the operation of the pause key
pause; 
close all force;