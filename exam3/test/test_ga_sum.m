clear;

X = [-10000:0.1:10000];
[row,col]=size(X);
for l=1:col
%    for h=1:row
        z(l)=X(l);
%    end
end

length = 1;
% number of iterations to run
population = 1000;
% number of iterations to run
generation = 1000;
% convolution kernel size
filterSize = 3;
% Fish density threshold for determining which minima/maxima to return
minDensity = 30;
densityRange = 0.1;

minX = -10000;
maxX = 10000;

x = -1000 + rand(population, length) * 2000;
[row,col]=size(x);
for l=1:row
        score(l, 1)=x(l);
end

newPop = [x score];
% show init figure
hold on;
plot(X, z), axis on, xlabel('x'), ylabel('f(x)'), title('1D Sum function');
plot(newPop(:, 1), newPop(:, 2), 'b.');

for i = 1:generation
    sortedPop = sortrows(newPop, length + 1);
    sortedPop = flipud(sortedPop);
    % generate filter
    s = std(newPop, 0, 1);
    filter = [sortedPop(1, 1) - s(1); sortedPop(population/2, 1) - s(1); sortedPop(population, 1) - s(1)];
    % disp(filter);
    
    % Create a mating pool
    % parentPop = [0; sortedPop(:, 1); 0];
    parentPop = sortedPop(:, 1);
    childPop = imfilter(parentPop, filter);
    
    for l=1:row
        score(l, 1)=childPop(l);
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

% disp(newPop);
plot(newPop(:, 1), newPop(:, 2), 'g.');

% mark out significant points
densityPop = sortrows(newPop, 1);
densityPop = flipud(densityPop);
last = densityPop(1, :);
densityCount = 0;
densityGroup(1, :) = last;
g = 2;
c = 1;
for m=2:population
    tempDist = pdist([last; densityPop(m, :)],'euclidean');
    if tempDist > densityRange
        densityCount = densityCount + 1;
        densityGroup(g, :) = densityPop(m, :);
        g = g + 1;
    else
        if densityCount > minDensity
            densityGroup = sortrows(densityGroup, 2);
            densityGroup = flipud(densityGroup);
            densityResult(c, 1:2) = densityGroup(1, :);
            densityResult(c, 3) = g - 1;
            c = c + 1;
            densityCount = 0;
            densityGroup = [0, 0];
            g = 1;
        end
    end
    
    last = densityPop(m, :);
end

disp(densityResult);

densityResult = sortrows(densityResult, 3);
densityResult = flipud(densityResult);
dsum = sum(densityResult(:, 3));
for n=1:c-1
    plot(densityResult(n, 1), densityResult(n, 2), 'rO', 'MarkerSize', densityResult(n, 3)/dsum * 40 + 1, 'MarkerFaceColor',[1,0,0]);
end

hold off;
