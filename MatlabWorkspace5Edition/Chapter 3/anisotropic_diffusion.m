function diffused = anisotropic_diffusion(image,iterations,lambda,k)
%Add mean-zero Gaussian noise
%
%  Usage: new image =  anisotropic_diffusion(array,value,value,value)
%
%  Parameters: image        - array of points 
%              iterations   - number of iterations
%              lambda       - level of isotropic smoothing
%              iterations   - edge preservation

%get dimensions
[rows,cols]=size(image);
%initialise an output image (borders)
new_diffused(1:rows,1:cols)=0;
%iterative process starting from input image
diffused=image;
for i=1:iterations
    for x = 2:cols-1 %address all columns 
        for y = 2:rows-1 %address all rows
            %calculate the weighted compass differences, Eqs. 3.43-3.46
            gE=(diffused(y,x-1)-diffused(y,x))*exp(-((diffused(y,x-1)-diffused(y,x))^2)/(k*k));
            gW=(diffused(y,x+1)-diffused(y,x))*exp(-((diffused(y,x+1)-diffused(y,x))^2)/(k*k));
            gN=(diffused(y-1,x)-diffused(y,x))*exp(-((diffused(y-1,x)-diffused(y,x))^2)/(k*k));
            gS=(diffused(y+1,x)-diffused(y,x))*exp(-((diffused(y+1,x)-diffused(y,x))^2)/(k*k));
            %from the new point, Eq. 3.48
            new_diffused(y,x)=diffused(y,x)+lambda*(gW+gE+gN+gS);
        end
    end
    %copy it back to start next iteration
    diffused=new_diffused;
end


