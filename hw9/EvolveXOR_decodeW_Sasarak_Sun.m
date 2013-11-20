function [ w ] = EvolveXOR_decodeW_Sasarak_Sun( neurons,  vector)
%EvolveXOR_decodeW_Sasarak_Sun Summary of this function goes here
%   Detailed explanation goes here

w = zeros(2, 2 + neurons + 1);

switch neurons
    case 2
        w = [vector(1:3) 0 0; vector(4:7) 0];
	case 4
        w = [vector(1:3) 0 0 0 0; vector(4:7) 0 0 0; 0 0 vector(8:10) 0 0; 0 0 vector(11:14) 0];
    otherwise
        warning('Unexpected neuron number! w cannot be generated! ');
end

end

