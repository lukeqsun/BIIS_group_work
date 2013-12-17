function [ newPop ] = SchoolingFish2_Sasarak_Sun(newPop, inputRange, popSize, maxPopSize, filterSize, density, generation, pruneProbability)
%SCHOOLING FISH algorithm implementation for detecting the minimums of one dimensional objective function
%   Parameters:
%   newPop - the data of the inital population or the last population which
%           is generated, and the fitness score of this population;
%   inputRange - the possible range of the input data;
%   popSize - the population size of the newPop
%   maxPopSize - a temporary affordable population which is used to hold
%           the extra extended members;
%   filterSize - the size of the filter which is applied to the generation;
%   density - the parameter for the cutoff threshold during the hierarchical clustering;
%           the individuals will be grouped according to this value;
%           the smaller the value is, more clusters will be discovered;
%   generation - the maximum generation the algorithm will process
%   pruneProbability - the probability of pruning the data in each
%           generation
%
%   Return
%   newPop - the last population

for g = 1:generation
    [row, col] = size(newPop);
    
    % sort the population according to its fitness score
    sortedPop = sortrows(newPop, 3);

    % generate the "genetic" filter
    s = std(newPop, 0, 1);
    genFilter(1, 1) = sortedPop(1, 1) - s(1);
    for i = 1:(filterSize - 2)
        genFilter(1, i + 1) = sortedPop(round(row * i / (filterSize - 1)), 1) - s(1);
    end
    genFilter(1, filterSize) = sortedPop(row, 1) - s(1);
    
    genFilter(2, 1) = sortedPop(1, 2) - s(2);
    for i = 1:(filterSize - 2)
        genFilter(2, i + 1) = sortedPop(round(row * i / (filterSize - 1)), 2) - s(2);
    end
    genFilter(2, filterSize) = sortedPop(row, 2) - s(2);

    % Create a mating pool
    parentPop = sortedPop(:, 1:2);
    
    % Apply the filter to the parents to generate the children;
    childPop = imfilter(parentPop, genFilter);
    % calculate the fitness score of the children
    score = ObjectiveFunction2_Sasarak_Sun( childPop(:, 1), childPop(:, 2) );
    
    % Add all the parents to the next population
    newPop = sortedPop;
    
    % Place children into population
    p = row;
    for q = 1 : row
        % Only insert the child into population if it is in the possible range
        if childPop(q, 1) > inputRange(1) && childPop(q, 1) < inputRange(2) && childPop(q, 2) > inputRange(1) && childPop(q, 2) < inputRange(2)
            if p < maxPopSize
                % if the population does not reaches the maximum affordable
                % size, just add the child into the population;
                newPop(p + 1, :) = [childPop(q, 1:2), score(q, 1)];
                p = p + 1;
            else
                % if the population reaches the maximum affordable size,
                % pruning the population
                PruningPopulation_Sasarak_Sun;
            end
        end
    end
    
    % Pruning the population to the initial size according to the probability
    % or if the population reaches the maximum affordable size
    if (rand < pruneProbability && g > 1) || p > maxPopSize
        PruningPopulation_Sasarak_Sun;
    end
end

PruningPopulation_Sasarak_Sun;

end
