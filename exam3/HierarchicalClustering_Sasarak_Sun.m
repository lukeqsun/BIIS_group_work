function [ hidx, sortedClustCount ] = HierarchicalClustering_Sasarak_Sun( data, threshold )
% Devide the data into groups by hierarchical clustering
%   Return
%   hidx - the hierarchical index of the data
%   sortedClustCount - the table number of the members in each cluster,
%           sorted in ascending order

% clustering according to the distance between the data
eucD = pdist(data,'euclidean');
clustTreeEuc = linkage(eucD,'average');
hidx = cluster(clustTreeEuc,'criterion','distance','cutoff', threshold);

for i = 1:max(hidx)
    clust = find(hidx==i);
    clustCount(i) = size(clust, 1);
end

sortedClustCount = sortrows([rot90(1:max(hidx), -1) rot90(clustCount, -1)], 2);

end

