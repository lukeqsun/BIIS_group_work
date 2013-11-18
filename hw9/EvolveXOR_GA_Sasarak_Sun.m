function [ W, bestError ] = EvolveXOR_GA_Sasarak_Sun(population, generation, tournament, probability, operator, n )
%EVOLVEXOR_GA_SASARAK_SUN Summary of this function goes here
%   Detailed explanation goes here

% input = [1, 1; 1, 0; 0, 1; 0, 0];
input = [1, 1, 0, 0; 1, 0, 1, 0; 1, 1, 1, 1; 0, 0, 0, 0; 0, 0, 0, 0];

% Create a random population
for i = 1 : population
    % randn(2, 5) * 100 .* [1, 1, 1, 0, 0; 1, 1, 1, 1, 0]
    initPop(i, :) = randn(1, 10) * 100 .* [1, 1, 1, 0, 0, 1, 1, 1, 1, 0];
end



end

