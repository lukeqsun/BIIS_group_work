function [ err1, Iin1, Iin2, x2out ] = bestOP_Sasarak_Sun( w, input )
%BESTOP Summary of this function goes here
%   Detailed explanation goes here

Iin1 = input(1);
Iin2 = input(2);

x = tanh(w * input);
input(4) = x(1);
x = tanh(w * input);
x2out = x(2);

err1 = 0;

end

