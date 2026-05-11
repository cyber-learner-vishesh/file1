clc;
clear;


px = [0.5 0.5];  


pygx = [0.9 0.1;
        0.2 0.8];


n = length(px);


Hx = 0;
for i = 1:n
    if px(i) > 0 then
        Hx = Hx - px(i) * log2(px(i));
    end
end

disp("Entropy H(X) = ");
disp(Hx);


Hy_nf = Hx;     
Hygx_nf = 0;   

Ixy_nf = Hy_nf - Hygx_nf;

disp("---- Noise Free Channel ----");
disp("Mutual Information I(X;Y) = ");
disp(Ixy_nf);

// ----------- NOISY CHANNEL -----------

// Compute P(Y)
py = zeros(1, n);

for j = 1:n
    for i = 1:n
        py(j) = py(j) + px(i) * pygx(i,j);
    end
end


Hy = 0;
for j = 1:n
    if py(j) > 0 then
        Hy = Hy - py(j) * log2(py(j));
    end
end


Hygx = 0;
for i = 1:n
    for j = 1:n
        if pygx(i,j) > 0 then
            Hygx = Hygx - px(i) * pygx(i,j) * log2(pygx(i,j));
        end
    end
end


Ixy = Hy - Hygx;

disp("---- Noisy Channel ----");
disp("Output Probabilities P(Y) = ");
disp(py);

disp("Entropy H(Y) = ");
disp(Hy);

disp("Conditional Entropy H(Y|X) = ");
disp(Hygx);

disp("Mutual Information I(X;Y) = ");
disp(Ixy);
