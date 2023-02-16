function [U] = U_Charlie_gen(~)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
U = eye(16);
for i=0:15
    binStr = dec2bin(i,4);
    C1 = binStr(1);
    C2 = binStr(2);
    B = binStr(3);
    D = binStr(4);
    if(C1=='1')
        if(B=='1')
            U(i+1,i+1)=-1*U(i+1,i+1);
        end
    end
    if(C2=='1')
        if(D=='1')
            U(i+1,i+1)=-1*U(i+1,i+1);
        end
    end
    
end
end

