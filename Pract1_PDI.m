function Pract1_PDI

%%
%GROUP NUMBER: PDI4
%GROUP MEMBERS: Alex Cabezas Fontanals, Ricard Juan Pujol
%SOFTWARE & VERSION: 9.5.0,878302

%%
close all;

%Read the input image
[img_filename, img_pathname] = uigetfile({'*.jpg';'*.jpeg';'*.png'},'Choose an image');
img = imread(strcat(img_pathname,img_filename));




