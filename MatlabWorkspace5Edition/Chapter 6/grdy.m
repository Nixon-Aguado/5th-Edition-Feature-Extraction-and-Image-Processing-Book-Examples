function contour= grdy(edg,contour)
% Evaluates curvature energy
%
% Usage: set of new points= grdy(edge image, contour_points)
               
[rowsc,colsc]=size(contour);
[rows,cols]=size(edg);
for s=1:rowsc
    xmin=contour{s,1}; %initialise minimum values
    ymin=contour{s,2};
    forces=balanceforces(xmin,ymin,edg,s,contour); %balance all forces
    Emin=contour{s,3}*Econt(xmin,ymin,s,contour)+contour{s,4}*...
                     Ecur(xmin,ymin,s,contour)+contour{s,5}*edg(ymin,xmin);
    for x=contour{s,1}-1:contour{s,1}+1 %look around current contour point
        for y=contour{s,2}-1:contour{s,2}+1
            if ((x<cols+1)&&(x>1))&&((y<rows+1)&&(y>1))
                xx=x-contour{s,1}+2; %need to start from 1
                yy=y-contour{s,2}+2; 
                %now evaluate energy
                Ej=contour{s,3}*forces(yy,xx,1)+contour{s,4}*...
                                     forces(yy,xx,2)+contour{s,5}*edg(y,x);
                if Ej<Emin %is it a new minimum?
                    Emin=Ej; %store it
                    xmin=x;
                    ymin=y;
                end
            end
        end
    end
    %store minimum as new contour point
    contour(s,1:5)={xmin,ymin,contour{s,3},contour{s,4},contour{s,5}};
end
                    
    