
clear; clc;

input_bits = "0101111010"; 
bit_width = 5;            

function [encoded_output, dict_keys] = lzw_binary_encode(bin_str)
    
    dict_keys = list("0", "1");
    
    w = "";
    encoded_output = [];
    dict_size = 2;
    
    for i = 1:length(bin_str)
        c = part(bin_str, i);
        wc = w + c;
        
       
        found_idx = -1;
        for j = 1:length(dict_keys)
            if dict_keys(j) == wc then
                found_idx = j - 1;
                break;
            end
        end
        
        if found_idx <> -1 then
            w = wc;
        else
            
            for j = 1:length(dict_keys)
                if dict_keys(j) == w then
                    encoded_output($+1) = j-1;
                    break;
                end
            end

            dict_keys(dict_size + 1) = wc;
            dict_size = dict_size + 1;
            w = c;
        end
    end
    
 
    for j = 1:length(dict_keys)
        if dict_keys(j) == w then
            encoded_output($+1) = j-1;
            break;
        end
    end
endfunction


[codes, full_dict] = lzw_binary_encode(input_bits);

mprintf("\nLZW BINARY ENCODING TABLE\n");
mprintf("=========================================================\n");
mprintf("%-15s | %-15s | %-20s\n", "Partition/Entry", "Decimal Code", "Fixed Codeword");
mprintf("---------------------------------------------------------\n");

for i = 1:length(full_dict)
    phrase = full_dict(i);
    dec_val = i - 1;
    
 
    bin_codeword = dec2bin(dec_val, bit_width);
    
    mprintf("%-15s | %-15d | %-20s\n", phrase, dec_val, bin_codeword);
end

mprintf("=========================================================\n");
mprintf("Input Stream:  %s\n", input_bits);
mprintf("Encoded (Dec): "); disp(codes);
