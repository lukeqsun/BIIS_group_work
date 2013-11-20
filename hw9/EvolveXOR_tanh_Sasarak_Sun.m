function [ err, x2out ] = EvolveXOR_tanh_Sasarak_Sun( neurons, pop, input, target )
%EvolveXOR_Sigmoid_Sasarak_Sun Summary of this function goes here
%   Detailed explanation goes here

for i = 1 : size(pop, 1)
    
    w = EvolveXOR_decodeW_Sasarak_Sun(neurons, pop(i, :));
    
    for j = 1 : size(input, 1)
        in = [rot90(input(j, :), -1); 1; zeros(neurons, 1)];
        for k = 1 : neurons
            x = tanh(w * in);
            in(k + 3) = x(k);
        end
        x2out(i, j) = in(end);
    end

    err(i, :) = sum((abs(x2out(i, :) - target)).^2);
end

end

