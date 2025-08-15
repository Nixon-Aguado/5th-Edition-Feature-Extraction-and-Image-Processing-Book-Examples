%draw Fourier transforms
square(1:100,1:100)=0;
square(45:55,45:55)=1;
ftsquare=fft2(rearrange(square));
surf(abs(ftsquare))
sigma=10
gauss(1:100,1:100)=0;
for i=1:100
    for j=1:100
        gauss(j,i)=exp(-(((i-50)*(i-50)+(j-50)*(j-50)))/(sigma*sigma));
    end
end
ftgauss=fft2(rearrange(gauss));
