function [ vector1, vector2 ] = TwoPointCrossover_Sasarak_Sun( vector1,vector2 )
%TwoPointCrossover_Sasarak_Sun Summary of this function goes here
%   Detailed explanation goes here

    len = length(vector1);
    c = randi(len,1);
    d = randi(len,1);
    
    if(c>d)
        temp = c;
        c = d;
        d = temp;
    end
    
    if c~=d
        temp = vector1(c:d);
        vector1(c:d) = vector2(c:d);
        vector2(c:d) = temp;
    end
end

