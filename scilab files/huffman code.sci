clc;
clear;

symbols =['A''B''C''D''E'];
p= [0.4 0.2 0.2 0.1 0.1];
n = length(p);

H=0;
for i=1:n
    H= H+p(i)*;log2(1/p(i));
end

prob = p;
groups=[];
codes=[];

for i=1:n
    groups(i)=string(symbols(i));
    codes(i)="";
end

while length(prob)>1
    [prob,idx]=gsort(prob,"g","i");
    groups =groups(idx);
    
    g1 = groups($-1);
    g2 = groups($);
    
    for i = 1:length(g1)
        pos =find(sybols == part(g1 ,i));
        codes(pos)='0'+codes;
        
end

for i = 1:length(g2)
    pos = find(symbols ==part(g2,i));
    codes(pos)="1"+codes(pos);
   end
   newProb = prob($-1)+prob($);
   newgroup = g1+g2;
   prob=prob(1:$-2);
   groups=group2(1:$-2);
   
   prob($+1) = newProb;
    groups($+1) = newGroup;
end


L = 0;
for i=1:n
    L = L + p(i)*length(codes(i));
end

eff = (H/L)*100;


disp("Symbol   Probability   Huffman Code   Length");

for i=1:n
    mprintf("  %c        %.2f          %s           %d\n", ...
    symbols(i), p(i), codes(i), length(codes(i)));
end

mprintf("\nEntropy = %.3f bits/symbol\n", H);
mprintf("Average Code Length = %.3f bits/symbol\n", L);
mprintf("Coding Efficiency = %.2f %%\n", eff);
end
