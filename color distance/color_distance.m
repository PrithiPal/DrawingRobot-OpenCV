function d=color_distance(C1,C2) 
% this function takes input two sets C1,C2 of L*a*b colors and outputs a
% number representing there resembelance/closeness. 

L1 = C1(1);
a1 = C1(2);
b1 = C1(3);

L2 = C2(1);
a2 = C2(2);
b2 = C2(3);


expr = (L1-L2).^2 + (a1-a2).^2 + (b1-b2).^2; % finds euclidean distance between color components
d = sqrt(expr);

end