%% EE425/EE453 Assignment Part 2
%
% binary Convolution.m
%%
clear all
clc
close all

% read in the image
letters=openimage('letters.jpg');

% load T image
temp = openimage('template_T.jpg');
temp2=vsg('MidThresh',temp);
letter_t =vsg('NOT',temp2);

% Convert to white text on a black background
[out_img1]=vsg('MidThresh',letters);
[out_img2]=vsg('NOT',out_img1);

% Convolve the text image with the N-tuple
[out_img3]=vsg('Convolution',out_img2,letter_t);

% Threshold the result of the convolution. A high output from the
% convolution indicates that the N-tuple is very similar to the region in
% the input image at the location of the high response.
thresh=vsg('HighestGrey',out_img3);
[out_img4]=vsg('Threshold',out_img3,thresh);
detect_bw = im2bw(out_img4);

[x, y] = find(detect_bw == 1);
image_output = letters;

for i=1:length(x)
    image_output = vsg('DrawCircle',image_output,[y(i,1),x(i,1)],35, [255,0,0],4);
end

% Display the images
h=figure; image(uint8(image_output)); colormap(gray); set(h,'Name','T Found');axis image;

%% part b repeat for a rotated image
rotated90 = vsg('RotateImg',out_img2,180);

[out_rotated]=vsg('Convolution',rotated90,letter_t);

threshrotate=vsg('HighestGrey',out_rotated);
[out_part2]=vsg('Threshold',out_rotated,threshrotate);
detect_bwr = im2bw(out_part2);

[xr, yr] = find(detect_bwr == 1);
image_outputrotate = vsg('NOT',rotated90);

for i=1:length(xr)
    image_outputrotate = vsg('DrawCircle',image_outputrotate,[yr(i,1),xr(i,1)],35, [255,0,0],4);
end
h=figure; image(uint8(image_outputrotate)); colormap(gray); set(h,'Name','T Found with rotated image');axis image;

%% part c impulse noise added
value = 0.2;
noise = vsg('S+PNoise',out_img2,value);
[out_noise]=vsg('Convolution',noise,letter_t);

threshnoise=(vsg('HighestGrey',out_noise) - round(255*value));
[out_partc]=vsg('Threshold',out_noise,threshnoise);
detect_bwn = im2bw(out_partc);

[xn, yn] = find(detect_bwn == 1);
image_outputnoise = vsg('NOT',noise);

for i=1:length(xn)
    image_outputnoise = vsg('DrawCircle',image_outputnoise,[yn(i,1),xn(i,1)],35, [255,0,0],4);
end
h=figure; image(uint8(image_outputnoise)); colormap(gray); set(h,'Name','T Found with noise image');axis image;

%% repeat the same for L
temp_l = openimage('template_L.jpg');
temp_l2=vsg('MidThresh',temp_l);
letter_l =vsg('NOT',temp_l2);

% Convolve the text image with the N-tuple
[out_convl]=vsg('Convolution',out_img2,letter_l);

% the input image at the location of the high response.
thresh2=vsg('HighestGrey',out_convl);
[out_result]=vsg('Threshold',out_convl,thresh2);
detect_bw2 = im2bw(out_result);

[x2, y2] = find(detect_bw2 == 1);
image_output2 = letters;

for i=1:length(x2)
    image_output2 = vsg('DrawCircle',image_output2,[y2(i,1),x2(i,1)],35, [255,255,0],4);
end

%h=figure; image(uint8(out_convl)); colormap(gray); set(h,'Name','Letter Locations');axis image;
h=figure; image(uint8(image_output2)); colormap(gray); set(h,'Name','L Found');axis image;

%% final result

result = vsg('Add',image_output,image_output2);
h=figure; image(uint8(result)); colormap(gray); set(h,'Name','Circle around L & T');axis image;
