clc;
clear;
close all;

% comparing distances and finding optimal pen for color selection
n=6;
PEN_DATA = csvread('color_index_csv.csv'); % 47 vcolo
NORM_PEN_DATA = PEN_DATA./255;
NORM_PEN_DATA = NORM_PEN_DATA(:,2:4);
LAB_PEN_DATA = rgb2hsv(NORM_PEN_DATA);

REGION_DATA = csvread('regions/region_color.csv');
NORM_REGION_DATA = REGION_DATA./255;
LAB_REGION_DATA = rgb2hsv(NORM_REGION_DATA);

% distance vector for each region; min(d) gives best color resembelance

d = zeros([1, size(PEN_DATA,1)]);  % for HSV Euclidean distance

% matrix with optimal pen values.

optimal = zeros([1 size(REGION_DATA,1)]); % for HSV Euclidean distance

for i=(1:size(REGION_DATA,1))
   
    d = zeros([1, size(PEN_DATA,1)]);
    region_color = LAB_REGION_DATA(i,:);
    
    for j=(1:size(PEN_DATA,1))
        a = j ;
        pen_color = LAB_PEN_DATA(j,:);
        if i>1
            for k = 1:i-1
                op_val = optimal(k);
                used = LAB_PEN_DATA(op_val,:);
                if pen_color == used
                    pen_color = LAB_PEN_DATA(j+1,:);
                end
            end
        end

        d(1,j) = color_distance(region_color,pen_color);
       
    end
    
    [M1,I1]= min(d(:));
    optimal(i) = I1;
    
    
end
figure;
for i=(1:n)

    euclid_color = PEN_DATA(optimal(i),2:4);
    orig_color = REGION_DATA(i,:);
    
    color_patch_euclid = ones([100 100 3]);
    color_patch_orig = ones([100 100 3]);
    
    color_patch_euclid(:,:,1) = euclid_color(1,1)./255;
    color_patch_euclid(:,:,2) = euclid_color(1,2)./255;
    color_patch_euclid(:,:,3) = euclid_color(1,3)./255;
    
    color_patch_orig(:,:,1) = orig_color(1,1)./255;
    color_patch_orig(:,:,2) = orig_color(1,2)./255;
    color_patch_orig(:,:,3) = orig_color(1,3)./255;
    
    subplot(2,n,i),imshow(color_patch_orig);
    subplot(2,n,n+i),imshow(color_patch_euclid);
end