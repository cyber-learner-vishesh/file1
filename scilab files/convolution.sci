clc;
clear;


input_bits = [1 0 1 1];
n = length(input_bits);


g1 = [1 1 1];
g2 = [1 0 1];


reg = [0 0 0];


output = [];

disp("Input Bits:");
disp(input_bits);

disp(" " );
disp("Code Tree Generation:");

for i = 1:n
    
 
    reg = [input_bits(i) reg(1:$-1)];
    

    out1 = modulo(sum(reg .* g1), 2);
    out2 = modulo(sum(reg .* g2), 2);

    output = [output out1 out2];
    
 
    disp("Step " + string(i) + ":");
    disp("Register State:");
    disp(reg);
    disp("Output (g1 g2):");
    disp([out1 out2]);
    disp(" ");
end

disp("Final Encoded Output:");
disp(output);
