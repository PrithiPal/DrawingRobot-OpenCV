clc;
clear all;

input1 = '1.txt' ; %%input number one or name of first txt file
input2 = '2.txt' ; %%input number two or name of second txt file

file_readip = fopen(input1,'r');
i =0;
tline = fgetl(file_readip);
x_max = tline;
tline = fgetl(file_readip);
y_max = tline;
while(ischar(tline))
    i=i+1;
    tline = fgetl(file_readip);
    A{i} = tline;
end
fclose(file_readip);
file_readip2 = fopen(input2,'r');
i = 0;
tline2 = fgets(file_readip2);
x2 = tline2;
tline2 = fgets(file_readip2);
y2 = tline2;
while(ischar(tline2))
    i=i+1;
    tline2 = fgets(file_readip2);
    D{i} = tline2;
end
fclose(file_readip2);
y = length(A);
n =y-125;
j=n;
k=1;
while(n<y)
    C{k}=A{n};
    n=n+1;
    k=k+1;
end
n=1;
while(n<j)
    B{n}=D{n};
    n=n+1;
end
file_read2 = fopen('CODE.ino','r');
p=1;
tline1 = fgets(file_read2);
E{p} = tline1;
while(p<511)
  p=p+1;
  tline1 = fgets(file_read2);
  E{p}=tline1;
end
fclose(file_read2);
y1 = length(E);

file_write = fopen('src\MAIN_V2.ino','w');
fprintf(file_write,'%s\n','//======================================//');
fprintf(file_write,'%s\n','//               XFOX                   //');
fprintf(file_write,'%s\n','//               XFOX                   //');
fprintf(file_write,'%s\n','//======================================//');
fprintf(file_write,'%s\n','');
fprintf(file_write,'%s\n','#include <Arduino.h>');
fprintf(file_write,'%s\n','#include <Servo.h>');
fprintf(file_write,'%s\n','#include <avr/eeprom.h>');
fprintf(file_write,'%s\n','#include <PGMWrap.h>');
fprintf(file_write,'%s\n','');
fprintf(file_write,'%s','const uint8_p arr1[][');
fprintf(file_write,'%s',x_max);
fprintf(file_write,'%s\n','] PROGMEM =');
fprintf(file_write,'%s\n','{');
j =1;
u = length(B);
while(j<=u)
    fprintf(file_write,'%s',B{j});
    j=j+1;
end
fprintf(file_write,'%s\n','};');
fprintf(file_write,'%s\n','');
fprintf(file_write,'%s','const uint8_p arr2[][');
fprintf(file_write,'%s',x_max);
fprintf(file_write,'%s\n','] PROGMEM =');
fprintf(file_write,'%s\n','{');
 j = 1;
 u = length(C);
while(j<=u)
    fprintf(file_write,'%s\n',C{j});
    j=j+1;
end
fprintf(file_write,'%s\n','};');
fprintf(file_write,'%s\n','');
fprintf(file_write,'%s\n','//Variables//');
fprintf(file_write,'%s','int x_max = ');
fprintf(file_write,'%s',x_max);
fprintf(file_write,'%s\n','; // max valve in x');
fprintf(file_write,'%s','int y_max = ');
fprintf(file_write,'%s',y_max);
fprintf(file_write,'%s\n','; // paper max valve in y');
fprintf(file_write,'%s\n','');
j = 1;
while(j<y1)
    fprintf(file_write,'%s',E{j});
    j=j+1;
end

dos('platformio run');
dos('platformio run -t upload');
