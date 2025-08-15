function sq_image = square(a,b)
% Euclidan distance for DST
%
%  Usage: sq_image  = square(a,b)
%
%  Parameters:  a,b = size x,y
%               

sq_image(1:2*a,1:2*b)=0;
for i=1:a
    for j=1:b
        sq_image(i+floor(a/2),j+floor(b/2))=255;
    end
end