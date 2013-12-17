function [ Z ] = ObjectiveFunction1_Sasarak_Sun( X )
%The one dimensional objective function used for the GA.
%   The objecttive funcctional will be called in SchoolingFish1_Sasarak_Sun
%   for measuring the fitness. 
%   Remove/add the "%" symbol to enable/disable the function preferred. 
    
    [row,col]=size(X);
    
    % handling 1 by N or N by 1 matrix
    if col == 1
        d = row;
    else
        d = col;
    end
    
    for l=1:d
        % t = Ackley_Sasarak_Sun( X(l), 0 );

        % t = Michalewicz_Sasarak_Sun( X(l), 0 );
            
        t = Rastrigin_Sasarak_Sun( X(l), 0 );
        
        Z(l) = t;
    end
    
    if col == 1
        Z = rot90(Z, -1);

end

