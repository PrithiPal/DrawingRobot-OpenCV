function S=scale_image(INPUT_IMAGE)
    % takes a colored input image and outputs corresponding scaled image.
   
    %OUTPUT_IMAGE_FILENAME = 'all_shapes_final.jpg'
    %OUTPUT_FILENAME = 'MATRIX.txt';

    M = 220;
    N = 280;

    %I = imread(INPUT_IMAGE);
    %J = rgb2gray(INPUT_IMAGE);
    
    
    J = INPUT_IMAGE; % 2d image
    R = zeros(size(J));

    m = size(J,1);
    n = size(J,2); 

    % rotation
    if n>m
        if size(size(INPUT_IMAGE),2) == 3 % 3d or colored image
            
            Mat = permute(J,[2 1 3]);
            
            R = Mat;
            m = size(R,1);
            n = size(R,2); 
        
              
        elseif  size(size(INPUT_IMAGE),2) == 2 % 2d or grayscale image
            disp('asf');
            R = J.';
            m = size(R,1);
            n = size(R,2); 
        end

    else
        R = J;
    end
    %figure,imshow(R);

    % scaling
    k=1;
    if ((m>M) & (n>N))

        diff1 = M-m;
        diff2 = N-n;

        if diff1 > diff2
            k = N/n;
        elseif diff1 < diff2
            k = M/m;
        else % diff1 = diff2
            k = M/m; % take any
        end


    elseif(m>M && n<N)
            k = M/m;
    elseif(m<M && n>N)
            k = N/n;
    elseif(m<M && n<N)
        diff1 = M-m;
        diff2 = N-n;

        if diff1 > diff2
            k = M/m;
        elseif diff1 < diff2
            k = N/n;
        else % diff1 = diff2
            k = M/m; % take any
        end
    end
   
    S = imresize(R,k);
    %figure,imshow(S);
    %subplot(1,3,1),imshow(J),title('original')
    %subplot(1,3,2),imshow(R),title('rotated')
    %subplot(1,3,3),imshow(S),title('scaled')

    %imwrite(S,OUTPUT_IMAGE_FILENAME);
    %output_image_matrix(S,OUTPUT_FILENAME) ;
end
    
