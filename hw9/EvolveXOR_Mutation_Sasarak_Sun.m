function [ result ] = EvolveXOR_Mutation_Sasarak_Sun( vector, n )
%EVOLVEXOR_MUTATION_SASARAK_SUN Summary of this function goes here
%   Detailed explanation goes here

    len = length(vector);

    for i = 1 : n
        index = randi(len);
        vector(index) = vector(index) + randn * 100;
    end
    
    result = vector;
    
end

