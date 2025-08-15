function contour_energy= Econt(x,y,s,contour)
% Evaluates contour energy
%
% Usage: contour_energy= Econt(xcoord, ycoord, point, contour_points)
               
[rowsc,colsc]=size(contour);
sum=0;
for i=1:rowsc
    sum=sum+dist(i,contour); %sum up distances
end
D=sum/rowsc; %normalise
contour_energy=abs(D-dist2(x,y,s,contour)); %and return difference