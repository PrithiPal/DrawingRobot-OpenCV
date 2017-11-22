clc;
clear;
close all;

n=6;

figure;

ORIG = imread('fabric.png');
ORIG_SCALED = scale_image(ORIG);
COLOR_FILE = fopen('regions/region_lab_colors.txt','w');
LAB_MATRIX = zeros([n 3]);


for i=(1:n)

    I = imread(strcat(strcat('regions/region_',int2str(i)),'.bmp'));
    % REGION BW IMAGES
    subplot(3,n,i),imshow(I);
    
    J = ORIG_SCALED;
    
    
    R = J(:,:,1);
    G = J(:,:,2);
    B = J(:,:,3);
    
    R(I~=1)=0;
    G(I~=1)=0;
    B(I~=1)=0;

    J(:,:,1) = R;
    J(:,:,2) = G;
    J(:,:,3) = B;
    
    % REGION COLORED IMAGES
    subplot(3,n,i+n),imshow(J);
    
    avg_colored_lab = average_color(J);
    
    L = avg_colored_lab(1);
    a = avg_colored_lab(2);
    b = avg_colored_lab(3);
    
    color_matrix = ones([size(J,1) size(J,2) 3]);
    
    color_matrix(:,:,1) = L;
    color_matrix(:,:,2) = a;
    color_matrix(:,:,3) = b;
    
    
    LAB_MATRIX(i,1) = L;
    LAB_MATRIX(i,2) = a;
    LAB_MATRIX(i,3) = b;
    
    
    show_color_matrix = lab2rgb(color_matrix);
    % SHOW AVERAGED COLOR
    subplot(3,n,i+2*n),imshow(show_color_matrix);
    
    % PRINTING RGB COLOR TO FILE
    csvwrite('regions/region_color.csv',lab2rgb(LAB_MATRIX,'OutputType','uint8'));
    
end