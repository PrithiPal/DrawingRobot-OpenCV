function print_two_dim_matrix(IMAGE,OUTPUT_FILENAME)
    % IMAGE = BINARY IMAGE
    % this function prints the two dimensonal matrix with format 1,2,1,2,
    % ...
    
    

    
    OUTPUT_FILE = fopen(OUTPUT_FILENAME,'w');
    I = IMAGE; %% binary image

    M = size(I,1);
    N = size(I,2);

    for i=(1:M)
        fprintf(OUTPUT_FILE,'{');
        for j=(1:N)
            elem = I(i,j);
            fprintf(OUTPUT_FILE,'%d,',elem);
        end
        fprintf(OUTPUT_FILE,'}\n');
    end
    
end