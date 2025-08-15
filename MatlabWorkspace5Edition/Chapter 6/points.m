function contour = points(rad,no,xc,yc)
% Specifies and initial (Greedy) contour
%
%  Usage: points and weightings  = points(radius,number,xcentre,ycentre)
%
%  Parameters:  rad radius
%               no  number
%            xc,yc  xcentre,ycentre
%               

%contour(1:no,1:5)=0;
for s = 1:no %address all points
    x=floor(xc+rad*cos(s*2*pi/no)+0.5);
    y=floor(yc+rad*sin(s*2*pi/no)+0.5);
    alpha=0.5;
    beta=0.5;
    gamma=0.5;
    contour(s,1:5)={x,y,alpha,beta,gamma};
end