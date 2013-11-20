function [ bestVector, bestScore, sortedPop, bestScores ] = SimpleGA_MultipleOperator_Sasarak_Sun( length, population, generation, tournament, probability, operator, n, lastPop )
% Simple GA Algorithm
%   length - the length of the vector
%   population - the number of the vectors
%   generation - the max time the algorithm runs
%   tournament - the percentage of the population left in the mating pool
%   probability - the probability of the operator is applied
%   operator - the GA operator (crossover and mutation) to be applied
%       OnePointCrossover
%       TwoPointCrossover
%       UniformCrossover
%       Mutation
%   n - extra parameter left for the operator

% Sort population by fitness value
newPop = lastPop;
% Plot, initial population performance
%figure, imshow(newPop(:, 1:length)), axis on, xlabel('vector length'), ylabel('population members'), title('Initial population performance');

tournament = ceil(population * tournament);

for i = 1:generation
    % Sort population by fitness value
    sortedPop = flipud(sortrows(newPop, length + 1));
    bestScores(i) = sortedPop(1, length + 1);

    % If individual meets fitness requirement, DONE
    if sortedPop(1, length + 1) == length
        bestVector = sortedPop(1, 1:length);
        bestScore = sortedPop(1, length + 1);
        
        % Plot, performance vs generation
        % figure, plot(1:size(bestScores, 2), bestScores), xlabel('generation'), ylabel('performance'), title('performance vs generation');
        
        % Plot, final population performance
        %figure, imshow(sortedPop(:, 1:length)), axis on, xlabel('vector length'), ylabel('population members'), title('Final population performance');
        break
    end

    % Create a mating pool   
    % Tournament selection, select a certain percentage of the best ones
    parentPop = sortedPop(1:tournament, :);
    % Calculate some basic mathematic values
    totalScore = sum(parentPop(:, length + 1));
    % chromosomes with higher fitness values have more copies in the mating pool
    % highly fit individuals have a better chance of reproducing
    for j = 1 : tournament
        if size(parentPop(:, 1), 1) == population
            break
        end
        for k = 1 : ceil(parentPop(j, length + 1) / totalScore * (population - tournament))
            parentPop = [parentPop; parentPop(j, :)];
        end
    end
    % resort parent population
    parentPop = flipud(sortrows(parentPop, length + 1));

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
            case 'OnePointCrossover' 
                if randProbability(1) > probability
                        childCount = childCount + 2;
                        [childPop(1, :), childPop(2, :)] = OnePointCrossover_Sasarak_Sun(parentPop(randIndex(1), :), parentPop(randIndex(2), :));
                        childPop(1, length + 1) = sum(childPop(1, 1:length));
                        childPop(2, length + 1) = sum(childPop(2, 1:length));
                end
            case 'TwoPointCrossover' 
                if randProbability(1) > probability
                        childCount = childCount + 2;
                        [childPop(1, :), childPop(2, :)] = TwoPointCrossover_Sasarak_Sun(parentPop(randIndex(1), :), parentPop(randIndex(2), :));
                        childPop(1, length + 1) = sum(childPop(1, 1:length));
                        childPop(2, length + 1) = sum(childPop(2, 1:length));
                end
            case 'UniformCrossover' 
                if randProbability(1) > probability
                        childCount = childCount + 2;
                        [childPop(1, :), childPop(2, :)] = UniformCrossover_Sasarak_Sun(parentPop(randIndex(1), :), parentPop(randIndex(2), :), n);
                        childPop(1, length + 1) = sum(childPop(1, 1:length));
                        childPop(2, length + 1) = sum(childPop(2, 1:length));
                end
            case 'Mutation'
                for l = 1 : parentNum
                    if randProbability(l) > probability
                        childCount = childCount + 1;
                        childPop(l, :) = Mutation_Sasarak_Sun(parentPop(randIndex(l), :), n);
                        childPop(l, length + 1) = sum(childPop(l, 1:length));
                    end
                end
            otherwise
                warning('Unexpected operator type! No operator is applied. ');
        end

        % Place children into population
        % Only insert child into population if child is more fit than member it is replacing
        for q = 1 : childCount
            if childPop(q, length + 1) > parentPop(population, length + 1)
                p = p + 1;
                newPop(p, :) = childPop(q, :);
            end
        end
        
    % Continue until all chromosomes in population are children 
    end

% Completion of generation
end

if sortedPop(1, length + 1) ~= length
    % Return the best result if no individual meets the fitness requirement
    sortedPop = flipud(sortrows(newPop, length + 1));
    bestVector = sortedPop(1, 1:length);
    bestScore = sortedPop(1, length + 1);

    bestScores(generation) = sortedPop(1, length + 1);
    % Plot, performance vs generation
    % figure, plot(1:generation, bestScores), xlabel('generation'), ylabel('performance'), title('performance vs generation');

    % Plot, final population performance 
    % figure, imshow(sortedPop(:, 1:length)), axis on, xlabel('vector length'), ylabel('population members'), title('Final population performance');
end

end

