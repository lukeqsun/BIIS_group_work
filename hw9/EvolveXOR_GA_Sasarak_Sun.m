function [ W, bestError ] = EvolveXOR_GA_Sasarak_Sun(neurons, population, generation, tournament, probability, operator, n )
%EVOLVEXOR_GA_SASARAK_SUN Summary of this function goes here
%   Detailed explanation goes here

input = [1, 1; 1, 0; 0, 1; 0, 0];
target = [0 1 1 0];

Iin1 = input(:, 1);
Iin2 = input(:, 2);

length = 4 + (1 + neurons) * neurons / 2;

% Create a random population
initPop = randn(population, length) * 100;

[err, x2out] = EvolveXOR_tanh_Sasarak_Sun( neurons, initPop, input, target );
%[err, x2out] = EvolveXOR_Sigmoid_Sasarak_Sun( neurons, initPop, input, target );
newPop = [ initPop err ];

tournament = ceil(population * tournament);

for i = 1:generation
    % Sort population by fitness value
    sortedPop = sortrows(newPop, length + 1);
    bestErrors(i) = sortedPop(1, length + 1);
    
        % If individual meets fitness requirement, DONE
    if sortedPop(1, length + 1) == 0
        bestVector = sortedPop(1, 1:length);
        W = EvolveXOR_decodeW_Sasarak_Sun(neurons, bestVector);

        [err1, x2out] = EvolveXOR_tanh_Sasarak_Sun( neurons, bestVector, input, target );
        %[err1, x2out] = EvolveXOR_Sigmoid_Sasarak_Sun( neurons, bestVector, input, target );
        EvolveXOR_PrintResults_Sasarak_Sun( err1, Iin1, Iin2, x2out );
        
        bestError = sortedPop(1, length + 1);
        
        % Plot, performance vs generation
        figure, plot(1:size(bestErrors, 2), bestErrors), xlabel('generation'), ylabel('error'), title('error vs generation');
        
        break
    end
    
    parentPop = sortedPop(1:tournament, :);
    totalScore = sum(parentPop(:, length + 1));

    for j = 1 : tournament
        if size(parentPop(:, 1), 1) == population
            break
        end
        for k = 1 : ceil((totalScore - parentPop(j, length + 1)) / totalScore * (population - tournament))
            parentPop = [parentPop; parentPop(j, :)];
        end
    end
    % resort parent population
    parentPop = sortrows(parentPop, length + 1);

    p = 0;
    whileCount = 0;
    while p <= population && whileCount < population * 2
        % in case it never ends
        whileCount = whileCount + 1;
        
        % Randomly select two parents from the mating pool
        parentNum = 2;
        randIndex = randi(population, parentNum, 1);
        randProbability = rand(parentNum, 1);

        % With a given probability, apply GA operators (crossover and mutation)
        % Depending on the probability crossover or mutation operators may not be applied
        childCount = 0;
        switch operator
            %{
            case 'OnePointCrossover' 
                if randProbability(1) > probability
                        childCount = childCount + 2;
                        [childPop(1, :), childPop(2, :)] = OnePointCrossover_Sasarak_Sun(parentPop(randIndex(1), :), parentPop(randIndex(2), :));
                        childPop(1, length + 1) = EvolveXOR_Sigmoid_Sasarak_Sun( neurons, childPop(1, 1:length), input, target );
                        childPop(2, length + 1) = EvolveXOR_Sigmoid_Sasarak_Sun( neurons, childPop(2, 1:length), input, target );
                end
            case 'TwoPointCrossover' 
                if randProbability(1) > probability
                        childCount = childCount + 2;
                        [childPop(1, :), childPop(2, :)] = TwoPointCrossover_Sasarak_Sun(parentPop(randIndex(1), :), parentPop(randIndex(2), :));
                        childPop(1, length + 1) = EvolveXOR_Sigmoid_Sasarak_Sun( neurons, childPop(1, 1:length), input, target );
                        childPop(2, length + 1) = EvolveXOR_Sigmoid_Sasarak_Sun( neurons, childPop(2, 1:length), input, target );
                end
            case 'UniformCrossover' 
                if randProbability(1) > probability
                        childCount = childCount + 2;
                        [childPop(1, :), childPop(2, :)] = UniformCrossover_Sasarak_Sun(parentPop(randIndex(1), :), parentPop(randIndex(2), :), n);
                        childPop(1, length + 1) = EvolveXOR_Sigmoid_Sasarak_Sun( neurons, childPop(1, 1:length), input, target );
                        childPop(2, length + 1) = EvolveXOR_Sigmoid_Sasarak_Sun( neurons, childPop(2, 1:length), input, target );
                end
            %}
            case 'Mutation'
                for l = 1 : parentNum
                    if randProbability(l) > probability
                        childCount = childCount + 1;
                        childPop(l, :) = EvolveXOR_Mutation_Sasarak_Sun(parentPop(randIndex(l), :), n);
                        childPop(l, length + 1) = EvolveXOR_tanh_Sasarak_Sun( neurons, childPop(1, 1:length), input, target );
                        %childPop(l, length + 1) = EvolveXOR_Sigmoid_Sasarak_Sun( neurons, childPop(1, 1:length), input, target );
                    end
                end
            otherwise
                warning('Unexpected operator type! No operator is applied. ');
        end

        % Place children into population
        % Only insert child into population if child is more fit than member it is replacing
        for q = 1 : childCount
            if childPop(q, length + 1) < parentPop(population, length + 1)
                p = p + 1;
                newPop(p, :) = childPop(q, :);
            end
        end
        
    % Continue until all chromosomes in population are children 
    end

% Completion of generation
end

if sortedPop(1, length + 1) ~= 0
    % Return the best result if no individual meets the fitness requirement
    sortedPop = sortrows(newPop, length + 1);
    bestVector = sortedPop(1, 1:length);
    W = EvolveXOR_decodeW_Sasarak_Sun(neurons, bestVector);
    
    [err1, x2out] = EvolveXOR_tanh_Sasarak_Sun( neurons, bestVector, input, target );
    %[err1, x2out] = EvolveXOR_Sigmoid_Sasarak_Sun( neurons, bestVector, input, target );
    EvolveXOR_PrintResults_Sasarak_Sun( err1, Iin1, Iin2, x2out );
        
    bestError = sortedPop(1, length + 1);

    bestErrors(generation) = sortedPop(1, length + 1);
    % Plot, performance vs generation
    figure, plot(1:generation, bestErrors), xlabel('generation'), ylabel('error'), title('error vs generation');
end

end

