function [ vector1, vector2 ] = UniformCrossover_Sasarak_Sun( vector1, vector2, prob)
%UniformCrossover_Sasarak_Sun Summary of this function goes here
%   Detailed explanation goes here
    len = length(vector1);

    for i=1:1:len
        if prob >= rand
            temp2 = vector1(i);
            vector1(i) = vector2(i);
            vector2(i) = temp2;
        end
    end
end

