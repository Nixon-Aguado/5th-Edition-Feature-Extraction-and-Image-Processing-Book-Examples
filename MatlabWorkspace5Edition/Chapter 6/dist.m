function dist = dist(s,contour)
% Evaluates distance between two adjacent points
%
% Usage: Euclidean distance  = dist(point, contour_points)
%
               
[rowsc,colsc]=size(contour);
s2=s+1;
%sorry, dodgy modulo operator ...
if s2>rowsc
    s2=s2-rowsc;
end
dist=sqrt((contour{s,1}-contour{s2,1})^2+(contour{s,2}-contour{s2,2})^2);