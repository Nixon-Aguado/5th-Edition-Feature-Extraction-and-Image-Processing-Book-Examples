%first we'll do the distance weight
sigma=3;
[x]=0:0.1:10
dist=(1/sqrt(2*pi*sigma))*exp(-x/(1.414*sigma));
plot (x,dist)

%now the phase weight
[t]=-pi:.1:pi;
%term1
phasef=(1-cos(pi-t)).*2;
plot (t,phasef)
%term2
phasef=(1-cos(t)).*(1-cos(-t));
plot (t,phasef)

%surface of phase weighting for alpha=0
[t1,t2] = meshgrid(-pi:.1:pi);
z=(1-cos(t1+t2)).*(1-cos(t1-t2));
surf(t1,t2,z)
