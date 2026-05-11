clc;
clear;


input_bits = [1 0 1 1];


g1 = [1 1 1];
g2 = [1 0 1];

state = [0 0];


encoded = [];

disp("Input Bits:");
disp(input_bits);

disp(" ");
disp("Trellis Transitions:");

for i = 1:length(input_bits)
    
    input_bit = input_bits(i);
    
   
    reg = [input_bit state];
    
    
    out1 = modulo(sum(reg .* g1), 2);
    out2 = modulo(sum(reg .* g2), 2);
    

    encoded = [encoded out1 out2];
    
  
    next_state = [input_bit state(1)];
    

    disp("Step " + string(i) + ":");
    disp("Current State:");
    disp(state);
    disp("Input:");
    disp(input_bit);
    disp("Output (g1 g2):");
    disp([out1 out2]);
    disp("Next State:");
    disp(next_state);
    disp(" ");
    
   
    state = next_state;
end

disp("Final Encoded Sequence:");
disp(encoded);
