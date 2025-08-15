function curvature_energy= Ecur(x,y,s,contour)
% Evaluates curvature energy
%
% Usage: curvature_energy= Ecur(xcoord, ycoord, point, contour_points)
               
[rowsc,colsc]=size(contour);
s1=s-1+rowsc;
%sorry, dodgy modulo operator ...
if s1>rowsc
    s1=s1-rowsc;
end
s2=s+1;
%sorry, again ...
if s2>rowsc
    s2=s2-rowsc;
end

curvature_energy=abs((contour{s1,1}-2*x+contour{s2,1})^2+(contour{s1,2}-2*y+contour{s2,2})^2); %and return 