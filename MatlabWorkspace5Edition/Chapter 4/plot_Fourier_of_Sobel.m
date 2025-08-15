x=0:0.01:6;
f=asinh(2*(x-pi))/2;
plot(x,f)
hold on
df=2./sqrt(1+(4*(x-pi).*(x-pi)));
plot(x,df)
d2f=-8./(1+(4*(x-pi).*(x-pi))).^(3/2).*(x-pi);
plot(x,d2f)

%draw Fourier of Sobel operator
templates=Sobel_templates(19);
Ftemplates=fft2(rearrange(templates(:,:,1)));
%note that  with small templates like 5*5 it's fft not fft2 - dunno why
%(noting odd, and small)
bar3(abs(Ftemplates))
contour(abs(Ftemplates))
%now do Eq 4.15
[X,Y] = meshgrid(-pi:0.1:pi,-pi:0.1:pi);
Z = abs(cos(X/2).*cos(X/2).*sin(Y));
surf(X,Y,Z) % in book colour is summer


%now do LoG
b=fft2(rearrange(LoG_template(51,1.5)));
surf(abs(b))
imagesc(abs(b))