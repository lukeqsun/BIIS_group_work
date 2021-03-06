% script for running one dimensional Schooling Fish function
clear;

% drawing the background curve of the objective function
% the range of the input data can vary according to the objective function
inputRange = [-5, 5];
X = (inputRange(1):0.1:inputRange(2));
Z = ObjectiveFunction1_Sasarak_Sun( X );
plot(X, Z), axis on, xlabel('x'), ylabel('f(x)'), title('1D Schooling Fish Algorithm');
hold on;

% define the initial population size
popSize = 500;
% generate the initial population
initPop = inputRange(1) + rand(popSize, 1) * (inputRange(2) - inputRange(1));
score = ObjectiveFunction1_Sasarak_Sun( initPop );
lastPop = [ initPop score ];

% define the threshold for hierarchical clustering
density = 0.06;

% define the minimum size of the clusters which will be considered as
% features of the objective function
minClustSize = 10;

% SchoolingFish1_Sasarak_Sun(newPop, inputRange, popSize, maxPopSize, filterSize, density, generation, pruneProbability)
[ newPop ] = SchoolingFish1_Sasarak_Sun(lastPop, inputRange, popSize, 800, 5, density, 500, 0.6);

% drawing the initial population
plot(initPop, score, 'b.');

% draw the last population
plot(newPop(:, 1), newPop(:, 2), 'g.');

% calculate the number of the features detected and display the clusters
[ hidx, sortedClustCount ] = HierarchicalClustering1_Sasarak_Sun(newPop, density);

for i = 1:max(hidx)
    if sortedClustCount(i, 2) > minClustSize
        clust = find(hidx == sortedClustCount(i, 1));
        for j = 1:sortedClustCount(i, 2)
            plot(newPop(clust(j),1),newPop(clust(j),2), 'r+');
        end
    end
end

hold off;

% display the population size of each clusters
disp(rot90(sortedClustCount(:, 2)));

