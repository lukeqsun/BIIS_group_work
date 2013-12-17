% script for running two dimensional Schooling Fish function
clear;

% drawing the background curve of the objective function
% the range of the input data can vary according to the objective function
inputRange = [-1, 1];
[X, Y] = meshgrid(inputRange(1):0.02:inputRange(2));
Z = ObjectiveFunction2_Sasarak_Sun( X, Y );
hSurface = surf(X, Y, Z); axis on, xlabel('x'), ylabel('y'), zlabel('f(x. y)'), title('2D Schooling Fish Algorithm');
set(hSurface,'FaceColor',[0 0 0],'FaceAlpha',0.2, 'EdgeColor','none','LineStyle','none');
hold on;

% define the initial population size
popSize = 300;
% generate the initial population
initPop = inputRange(1) + rand(popSize, 2) * (inputRange(2) - inputRange(1));
score = ObjectiveFunction2_Sasarak_Sun(initPop(:, 1), initPop(:, 2));
lastPop = [ initPop score ];

% define the threshold for hierarchical clustering
density = 0.05;

% define the minimum member size of the clusters which will be considered as
% features of the objective function
minClustSize = 1;

% SchoolingFish2_Sasarak_Sun(newPop, inputRange, popSize, maxPopSize, filterSize, density, generation, pruneProbability)
[ newPop ] = SchoolingFish2_Sasarak_Sun(lastPop, inputRange, popSize, 500, 5, density, 15, 0.6);

% drawing the initial population
plot3(initPop(:, 1), initPop(:, 2), score, 'b.');

% draw the last population
plot3(newPop(:, 1), newPop(:, 2), newPop(:, 3), 'g.');

% calculate the number of the features detected and display the clusters
[ hidx, sortedClustCount ] = HierarchicalClustering_Sasarak_Sun(newPop, density);

for i = 1:max(hidx)
    if sortedClustCount(i, 2) > minClustSize
        clust = find(hidx == sortedClustCount(i, 1));
        for j = 1:sortedClustCount(i, 2)
            plot3(newPop(clust(j),1),newPop(clust(j),2), newPop(clust(j),3), 'w+');
        end
    end
end

hold off;

% display the population size of each clusters
disp(rot90(sortedClustCount(:, 2)));