clc;
clear;


function remainder = mod2div(dividend, divisor)
    n = length(divisor);
    temp = dividend;

    for i = 1:(length(dividend) - n + 1)
        if temp(i) == 1 then
            for j = 1:n
                temp(i+j-1) = modulo(temp(i+j-1) + divisor(j), 2);
            end
        end
    end

    remainder = temp($-n+2:$);
endfunction



data = [1 0 1 1];
generator = [1 0 1 1];

disp("Data Bits:");
disp(data);

disp("Generator:");
disp(generator);



n = length(generator);


data_appended = [data zeros(1, n-1)];


remainder = mod2div(data_appended, generator);


codeword = [data remainder];

disp(" ");
disp("ENCODING:");
disp("Remainder:");
disp(remainder);

disp("Encoded Codeword:");
disp(codeword);



disp(" ");
disp("DECODING:");


received = codeword;



disp("Received Codeword:");
disp(received);


check = mod2div(received, generator);

disp("Syndrome:");
disp(check);

if sum(check) == 0 then
    disp("No Error Detected");
else
    disp("Error Detected");
end
