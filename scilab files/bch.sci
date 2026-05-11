clc;
clear;


data = [1 0 1 1]; 


g = [1 0 1 1];

disp("Data Bits:");
disp(data);

disp("Generator Polynomial:");
disp(g);

function r = mod2div(dividend, divisor)
    n = length(divisor);
    temp = dividend;

    for i = 1:(length(dividend) - n + 1)
        if temp(i) == 1 then
            for j = 1:n
                temp(i+j-1) = modulo(temp(i+j-1) + divisor(j), 2);
            end
        end
    end

    r = temp($-n+2:$);
endfunction



disp(" ");
disp("ENCODING:");

k = length(data);
n = length(g);


data_app = [data zeros(1, n-1)];

rem = mod2div(data_app, g);


codeword = [data rem];

disp("Remainder:");
disp(rem);

disp("Encoded BCH Codeword:");
disp(codeword);



disp(" ");
disp("DECODING:");


received = codeword;
received(3) = modulo(received(3) + 1, 2);

disp("Received Codeword (with error):");
disp(received);

syn = mod2div(received, g);

disp("Syndrome:");
disp(syn);


if sum(syn) == 0 then
    disp("No Error Detected");
else
    disp("Error Detected");
    
    
    for i = 1:length(received)
        temp = received;
        temp(i) = modulo(temp(i) + 1, 2);
        
        check = mod2div(temp, g);
        
        if sum(check) == 0 then
            disp("Error corrected at position:");
            disp(i);
            disp("Corrected Codeword:");
            disp(temp);
            break;
        end
    end
end
