function [rho_out] = M_Charlie(rho_in)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
rho_out = sym(zeros(16,16));
t00 =[1,2,3,4,17,18,19,20,33,34,35,36,49,50,51,52,5,6,7,8,21,22,23,24,37,38,39,40,53,54,55,56,9,10,11,12,25,26,27,28,41,42,43,44,57,58,59,60,13,14,15,16,29,30,31,32,45,46,47,48,61,62,63,64];

for i=1:16
    for j=1:16
        rho_out(i,j) = sum(sum(rho_in(t00(4*(i-1)+1:4*i),t00(4*(j-1)+1:4*j))));
    end
end
end

