function [  ] = EvolveXOR_PrintResults_Sasarak_Sun( err, Iin1, Iin2, x2out )
%EVOLVEXOR_PRINTRESULTS_SASARAK_SUN Summary of this function goes here
%   Detailed explanation goes here
for i = 1 : 4
fprintf('err1 = %s  Iin1 = %s  Iin2 = %s  x2out = %s\n', num2str(err), num2str(Iin1(i)), num2str(Iin2(i)), num2str(x2out(i)));
end

end

