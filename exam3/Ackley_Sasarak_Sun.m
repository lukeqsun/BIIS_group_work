function [ z ] = Ackley_Sasarak_Sun( x, y )
%ACKLEY function

z=(-20*exp(-0.2*sqrt(0.5*(x^2+y^2)))-exp(0.5*(cos(2*pi*x)+cos(2*pi*y)))+20+exp(1));

end

