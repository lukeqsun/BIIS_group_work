function [ W, bestError ] = EvolveXOR_ES2_Sasarak_Sun( neurons, mu, lambda, generation, operator, n )
%EVOLVEXOR_ES2_SASARAK_SUN Summary of this function goes here
%   Detailed explanation goes here

input = [1, 1; 1, 0; 0, 1; 0, 0];
target = [0 1 1 0];

Iin1 = input(:, 1);
Iin2 = input(:, 2);

length = 4 + (1 + neurons) * neurons / 2;

% Create a random population
initPop = randn(lambda, length) * 100;

%[err, x2out] = EvolveXOR_tanh_Sasarak_Sun( neurons, initPop, input, target );
[err, x2out] = EvolveXOR_Sigmoid_Sasarak_Sun( neurons, initPop, input, target );
newPop = [ initPop err ];

for i = 1:generation
    % Sort population by fitness value
    sortedPop = sortrows(newPop, length + 1);
    bestErrors(i) = sortedPop(1, length + 1);
    
        % If individual meets fitness requirement, DONE
    if sortedPop(1, length + 1) == 0
        bestVector = sortedPop(1, 1:length);
        W = EvolveXOR_decodeW_Sasarak_Sun(neurons, bestVector);

        %[err1, x2out] = EvolveXOR_tanh_Sasarak_Sun( neurons, bestVector, input, target );
        [err1, x2out] = EvolveXOR_Sigmoid_Sasarak_Sun( neurons, bestVector, input, target );
        EvolveXOR_PrintResults_Sasarak_Sun( err1, Iin1, Iin2, x2out );
        
        bestError = sortedPop(1, length + 1);
        
        % Plot, performance vs generation
        figure, plot(1:size(bestErrors, 2), bestErrors), xlabel('generation'), ylabel('error'), title('error vs generation');
        
        break
    end
    
    parentPop = sortedPop(1:mu, :);
    newPop = parentPop(1:mu, :);
    childCount = 0;
    for j = 1 : mu
        switch operator
            case 'Mutation'
                for l = 1 : lambda/mu
                    childCount = childCount + 1;
                    childPop = EvolveXOR_Mutation_Sasarak_Sun(parentPop(j, :), n);
                    %childPop(length + 1) = EvolveXOR_tanh_Sasarak_Sun( neurons, childPop(1:length), input, target );
                    childPop(length + 1) = EvolveXOR_Sigmoid_Sasarak_Sun( neurons, childPop(1:length), input, target );
                    newPop(mu + childCount, :) = childPop(:);
                end
            otherwise
                warning('Unexpected operator type! No operator is applied. ');
        end
    end

% Completion of generation
end

if sortedPop(1, length + 1) ~= 0
    % Return the best result if no individual meets the fitness requirement
    sortedPop = sortrows(newPop, length + 1);
    bestVector = sortedPop(1, 1:length);
    W = EvolveXOR_decodeW_Sasarak_Sun(neurons, bestVector);
    
    %[err1, x2out] = EvolveXOR_tanh_Sasarak_Sun( neurons, bestVector, input, target );
    [err1, x2out] = EvolveXOR_Sigmoid_Sasarak_Sun( neurons, bestVector, input, target );
    EvolveXOR_PrintResults_Sasarak_Sun( err1, Iin1, Iin2, x2out );
        
    bestError = sortedPop(1, length + 1);

    bestErrors(generation) = sortedPop(1, length + 1);
    % Plot, performance vs generation
    figure, plot(1:generation, bestErrors), xlabel('generation'), ylabel('error'), title('error vs generation');
end

end

