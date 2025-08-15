function normed=normalise_coeffs(pic)
%get size of picture
[rows,cols]=size(pic);
%sum up coefficients
sum=0;
for x=1:cols
    for y=1:rows
        %except d.c.
        if x~=1&&y~=1
           sum=sum+abs(pic(y,x))*abs(pic(y,x));
        end
    end
end
normed=abs(pic)/sqrt(sum);
end