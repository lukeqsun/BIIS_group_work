function [ Z ] = ObjectiveFunction2( X, Y )
%The two dimensional objective function used for the GA.
%   The objecttive funcctional will be called in SchoolingFish1_Sasarak_Sun
%   for measuring the fitness. 
%   Remove/add the "%" symbol to enable/disable the function preferred.
    
    [row,col]=size(X);
    
    for l=1:col
        for h=1:row
            %Z(l) = Ackley( X(l), Y(l) );

            %Z(l) = Michalewicz( X(l), Y(l) );

            Z(l) = Rastrigin( X(l), Y(l) );
        end
    end

end

