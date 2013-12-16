% script for running one dimensional Schooling Fish function
clear;

% drawing the background curve of the objective function
% the range of the input data can vary according to the objective function
minX = -5;
maxX = 5;
X = (minX:0.1:maxX);
Z = ObjectiveFunction1( X );
hold on;
plot(X, Z), axis on, xlabel('x'), ylabel('f(x)'), title('1D objective function');

% define the initial population size 
population = 10;
% generate the initial population
initPop = minX + rand(population, 1) * (maxX - minX);

% drawing the initial population
Z = ObjectiveFunction1( initPop );
plot(initPop, Z, 'b.');



