%Code for plotting Gabor wavelets
gaborw(1:101)=0;
gabor2dw(1:101,1:101)=0;
t0=0;
sigma=30;
omega=2*pi*0.04;
for t1=-50:50
    gaborw(t1+51)=exp(-j*omega*t1)*exp(-((t1-t0)/sigma)^2);
end
plot(real(gaborw))
pause;
for t1=-50:50
    for t2=-50:50
        gabor2dw(t1+51,t2+51)=exp(-j*omega*((t1-t0)+(t2-t0)))*exp(-((t1-t0)/sigma)^2+-((t2-t0)/sigma)^2);
    end
end
surf(real(gabor2dw))