function dist2 = dist2(x,y,s,contour)
% Evaluates distance between current and contour points
%
% Usage: Euclidean distance  = dist(xcoord, ycoord, point, contour_points)
%
               
[rowsc,colsc]=size(contour);
s2=s+1;
%sorry, dodgy modulo operator ...
if s2>rowsc
    s2=s2-rowsc;
end
dist2=sqrt((x-contour{s2,1})^2+(y-contour{s2,2})^2);