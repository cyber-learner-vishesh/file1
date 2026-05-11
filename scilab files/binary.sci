clc;
clear;


px = [0.5 0.5];  

p = 0.1;

pygx = [1-p  p;
        p  1-p];


Hx = 0;
for i = 1:2
    if px(i) > 0 then
        Hx = Hx - px(i) * log2(px(i));
    end
end

disp("Entropy H(X) = ");
disp(Hx);


Hy_ef = Hx;      
Hygx_ef = 0;    

Ixy_ef = Hy_ef - Hygx_ef;

disp("---- Error-Free Channel ----");
disp("Mutual Information I(X;Y) = ");
disp(Ixy_ef);


py = zeros(1,2);

for j = 1:2
    for i = 1:2
        py(j) = py(j) + px(i) * pygx(i,j);
    end
end


Hy = 0;
for j = 1:2
    if py(j) > 0 then
        Hy = Hy - py(j) * log2(py(j));
    end
end


Hygx = 0;
for i = 1:2
    for j = 1:2
        if pygx(i,j) > 0 then
            Hygx = Hygx - px(i) * pygx(i,j) * log2(pygx(i,j));
        end
    end
end


Ixy = Hy - Hygx;

disp("---- Binary Symmetric Channel ----");
disp("Output Probabilities P(Y) = ");
disp(py);

disp("Entropy H(Y) = ");
disp(Hy);

disp("Conditional Entropy H(Y|X) = ");
disp(Hygx);

disp("Mutual Information I(X;Y) = ");
disp(Ixy);
