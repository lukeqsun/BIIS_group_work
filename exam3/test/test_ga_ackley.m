clear;

X = [-2:0.1:2];
[row,col]=size(X);
for l=1:col
%    for h=1:row
        z(l)=Ackley(X(l),0);
%    end
end

length = 1;
% number of iterations to run
population = 20;
% number of iterations to run
generation = 10;
% convolution kernel size
filterSize = 3;

minX = -2;
maxX = 2;

x = -2 + rand(population, length) * 4;
[row,col]=size(x);
for l=1:row
        score(l, 1)=Ackley(x(l),0);
end

newPop = [x score];
% show init figure
hold on;
plot(X, z);
plot(newPop(:, 1), newPop(:, 2), 'r*');

for i = 1:generation
    sortedPop = sortrows(newPop, length + 1);
    
    % generate filter
    s = std(newPop, 0, 1);
    filter = [sortedPop(1, 1) - s(1); sortedPop(population/2, 1) - s(1); sortedPop(population, 1) - s(1)];
    disp(filter);
    
    % Create a mating pool
    % parentPop = [0; sortedPop(:, 1); 0];
    parentPop = sortedPop(:, 1);
    childPop = imfilter(parentPop, filter);
    
    for l=1:row
        score(l, 1)=Ackley(childPop(l),0);
    end
    
    % Place children into population
    % Only insert child into population if the child is in the possible
    % range
    newPop = sortedPop;
    p = row;
    for q = 1 : row
        if childPop(q, 1) > minX && childPop(q, 1) < maxX
                newPop(p, :) = [childPop(q, 1), score(q, 1)];
                p = p - 1;
        end
    end

    % plot(newPop(:, 1), newPop(:, 2), 'r*');
end

disp(newPop);
plot(newPop(:, 1), newPop(:, 2), 'g*');
hold off;
