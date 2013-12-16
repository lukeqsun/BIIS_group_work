function [ z ] = Michalewicz(  x, y  )
%MICHALEWICZ function

z = -(sin(x)*(sin(2*x^2/pi)^20) + sin(y)*(sin(2*y^2/pi)^20));

end

