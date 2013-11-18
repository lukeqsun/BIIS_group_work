function [ vector1, vector2 ] = OnePointCrossover_Sasarak_Sun( vector1, vector2 )
%OnePointCrossover_Sasarak_Sun Summary of this function goes here
%   Detailed explanation goes here

    len = length(vector1);
    c = randi(len,1);
    
    if(c ~= 1)
        temp = vector1(c:end);
        vector1(c:end) = vector2(c:end);
        vector2(c:end) = temp;
    end

end

