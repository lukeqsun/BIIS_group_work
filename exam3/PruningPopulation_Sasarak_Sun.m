% The script for pruning the population to the initial population size.

currentSize = size(newPop, 1);
while currentSize > popSize
    % clustering the new population
    [ hidx, sortedClustCount ] = HierarchicalClustering_Sasarak_Sun(newPop, density);
    
    % At least, we keep one cluster
    if max(hidx) < 2
        break;
    end
    
    % pruning the cluster with the smallest member
    clust = find(hidx == sortedClustCount(1, 1));
    % sort the indices in the cluster in descending order
    % so that the later rows deleted are correct
    clust = flipud(sortrows(clust));
    for i = 1:sortedClustCount(1, 2)
        newPop(clust(i), :) = [];
    end
    
    currentSize = size(newPop, 1);
    if currentSize >= maxPopSize
        warning('Error! Please choose a larger maxPopSize or a smaller popSize. ');
    end
end
