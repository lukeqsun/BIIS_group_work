clear;

X = [-5:0.1:5];
[row,col]=size(X);
for l=1:col
%    for h=1:row
        z(l)=Rastrigin(X(l),0);
%    end
end

plot(X, z), axis on, xlabel('x'), ylabel('f(x)'), title('1D Rastrigin function');