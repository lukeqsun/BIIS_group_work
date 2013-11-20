length = 10000;
population = 200;
generation = 20000;
tournament = 0.7;
probability = 0.5;
round = 2;

% Create a random population
initPop = randi([0 1], population, length);
% Evaluate all individuals in population
% Maximize number represented by binary vector 
score = sum(initPop(:, :), 2);
% Sort population by fitness value
lastPop = [ initPop score ];
totalBestScores = 0;

for i = 1 : generation/round    
    if ( mod(i, round) == 0)
        [ bestVector, bestScore, lastPop, lastBestScores ] = SimpleGA_MultipleOperator_Sasarak_Sun( length, population, 1, tournament, probability, 'UniformCrossover', 0.3, lastPop );
    else
        [ bestVector, bestScore, lastPop, lastBestScores ] = SimpleGA_MultipleOperator_Sasarak_Sun( length, population, round - 1, tournament, probability, 'Mutation', 1, lastPop );
    end
    
    totalBestScores = [totalBestScores lastBestScores];
    
    disp(bestScore);
    
    if bestScore == 10000
        break;
    end
end

figure, plot(1:size(totalBestScores, 2), totalBestScores), xlabel('generation'), ylabel('performance'), title('performance vs generation');
