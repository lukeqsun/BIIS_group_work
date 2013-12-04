function [ z ] = Rastrigin( x, y )
%RASTRIGIN Summary of this function goes here
%   Detailed explanation goes here
z = (-1)*(x^2 + y^2 - 10*cos(2*pi*x) - 10*cos(2*pi*y) + 20);

end
