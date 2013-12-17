function [ Z ] = ObjectiveFunction2_Sasarak_Sun( X, Y )
%The two dimensional objective function used for the GA.
%   The objecttive funcctional will be called in SchoolingFish1_Sasarak_Sun
%   for measuring the fitness. 
%   Remove/add the "%" symbol to enable/disable the function preferred.
    
    [row,col]=size(X);
    
    for l=1:col
        for h=1:row
            %Z(h, l) = Ackley_Sasarak_Sun( X(h,l),Y(h,l) );

            %Z(h, l) = Michalewicz_Sasarak_Sun( X(h,l),Y(h,l) );

            Z(h, l) = Rastrigin_Sasarak_Sun( X(h,l),Y(h,l) );
        end
    end

end

