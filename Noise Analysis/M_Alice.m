function [rho_out] = M_Alice(rho_in)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
rho_out = sym(zeros(4,4));
t00 =1:16;
k=1;
for i=1:4
    for j=1:4
        M = rho_in(t00(4*(i-1)+1:4*i),t00(4*(j-1)+1:4*j));
%         disp(simplify(M))
%         disp(k)
        rho_out(i,j) = sum(sum(M));
        k=k+1;
    end
end
end

