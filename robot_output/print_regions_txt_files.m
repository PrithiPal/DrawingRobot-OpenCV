clc;
clear;
close all;

% this function prints the matrix which robot reads into txt files.
n=6;

for i=(1:6) 
    IMAGE_FILENAME = strcat('regions/region_',int2str(i),'.bmp');
    I = imread(IMAGE_FILENAME);
    OUTPUT_FILENAME = strcat('region_text_files/region_text_',int2str(i),'.txt');
    print_two_dim_matrix(I,OUTPUT_FILENAME); 
end