function diff = difference_of_gaussians

for i=1:300
  diff(i,1)=exp(-(((i-150)*(i-150))/(2*16*16)));
  diff(i,2)=0.8*exp(-(((i-150)*(i-150))/(2*20*20)));
  diff(i,3)=diff(i,1)-diff(i,2);
end
