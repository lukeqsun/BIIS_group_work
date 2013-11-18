function [ result ] = Mutation_Sasarak_Sun( vector, n )
%Mutation_Sasarak_Sun Summary of this function goes here
%   vector - some bits of this the binary vector will be flipped
%   n - the number of the bits to be flipped

    len = length(vector);

    for i = 1 : n
        index = randi(len);
        vector(index) = ~vector(index);
    end
    
    result = vector;
    
end

