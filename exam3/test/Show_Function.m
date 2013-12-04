clear;

[X,Y]=meshgrid(-5:0.1:5);

[row,col]=size(X);
for l=1:col
    for h=1:row
        z(h,l)=Rastrigin(X(h,l),Y(h,l));
    end
end

surfc(X,Y,z);
