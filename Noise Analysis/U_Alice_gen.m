function [U] = U_Alice_gen(~)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
U = eye(16);
for i=0:15
    binStr = dec2bin(i,4);
    A1 = binStr(1);
    A2 = binStr(2);
    B = binStr(3);
    D = binStr(4);
    dl = 0;
    if(A1=='1')
        if(B=='1')
            dl = dl-2;
        else
            dl = dl+2;
        end
    end
    if(A2=='1')
        if(D=='1')
            dl = dl-1;
        else
            dl = dl+1;
        end
    end
    if(A1=='1' || A2=='1')
         U(i+1,i+1)=0;
         U(i+1+dl,i+1)=1;
    end
    
end
end

