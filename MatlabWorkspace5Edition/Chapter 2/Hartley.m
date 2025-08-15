function trans = Hartley(image)
%Computes Hartley transform. Gives real image as result
%
%  Usage: [new image] = Hartley(image)
%
%  Parameters: image      - array of points 

%get dimensions
[rows,cols]=size(image); 

trans(1:rows,1:cols)=0;

%compute transform
for u = 1:cols %address all columns
    for v = 1:rows %address all rows
        sum=0;
        for x = 1:cols %address all columns 
            for y = 1:rows %address all rows
                %Eq. 2.41
                mux=2*pi*(u-1)*(x-1)/cols;
                nvy=2*pi*(v-1)*(y-1)/rows;
                sum=sum+(image(y,x)*(cos(nvy)+sin(nvy))*(cos(mux)+sin(mux)));
            end
        end
        trans(v,u)=sum/sqrt(rows*cols);
    end
end
