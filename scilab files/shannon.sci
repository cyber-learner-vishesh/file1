clc;
clear;

symbols = ['A' 'B' 'C' 'D' 'E'];
p = [0.4 0.2 0.2 0.1 0.1];
n = length(p);

H = 0;
for i=1:n
    H = H + p(i)*log2(1/p(i));
end

[p_sorted, idx] = gsort(p, "g", "i");

codes = [];
for i=1:n
    codes(i) = "";
end

stack = [1 n];

while size(stack,1) > 0

    l = stack($,1);
    r = stack($,2);
    stack($,:) = [];

    if l >= r then
        continue
    end

    total = sum(p_sorted(l:r));
    acc = 0;
    split = l;

    for i=l:r
        acc = acc + p_sorted(i);
        if acc >= total/2 then
            split = i;
            break
        end
    end

    for i=l:split
        codes(idx(i)) = codes(idx(i)) + "0";
    end

    for i=split+1:r
        codes(idx(i)) = codes(idx(i)) + "1";
    end

    stack = [stack; l split];
    stack = [stack; split+1 r];
end

L = 0;
for i=1:n
    L = L + p(i)*length(codes(i));
end

eff = (H/L)*100;

disp("Symbol   Probability   Shannon-Fano Code   Length");

for i=1:n
    mprintf("  %c        %.2f            %s             %d\n", ...
    symbols(i), p(i), codes(i), length(codes(i)));
end

mprintf("\nEntropy = %.3f bits/symbol\n", H);
mprintf("Average Code Length = %.3f bits/symbol\n", L);
mprintf("Coding Efficiency = %.2f %%\n", eff);
