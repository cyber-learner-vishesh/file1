clc;
clear;


P = [1 1 0;
     0 1 1;
     1 0 1];

I = eye(3,3);
G = [I P];

disp("Generator Matrix G:");
disp(G);


H = [P' eye(3,3)];

disp("Parity Check Matrix H:");
disp(H);


disp(" ");
disp("----- CODEWORD TABLE (6,3) -----");
disp("Dec   m1 m2 m3   |   Codeword (6-bit)");

codewords = [];

for i = 0:7
    
    m = [bitget(i,3) bitget(i,2) bitget(i,1)];
    
   
    c = modulo(m * G, 2);
    
    codewords = [codewords; c];
    
   
    mprintf("%d     %d  %d  %d    |   %d %d %d %d %d %d\n", ...
        i, m(1), m(2), m(3), ...
        c(1), c(2), c(3), c(4), c(5), c(6));
end


index = grand(1,1,"uin",1,8);
original = codewords(index,:);

disp(" ");
disp("Selected Original Codeword:");
disp(original);

error_pos = grand(1,1,"uin",1,6);
received = original;

received(error_pos) = modulo(received(error_pos)+1,2);

disp("Received Codeword (with error):");
disp(received);

disp("Actual Error Position:");
disp(error_pos);


S = modulo(received * H', 2);

disp("Syndrome:");
disp(S);


found = 0;

for i = 1:6
    if H(:,i)' == S then
        disp("Detected Error Position:");
        disp(i);
        found = 1;
        break;
    end
end

if found == 0 then
    disp("No error or multiple errors detected");
end
