function nforces= balanceforces(x,y,edg,pos,contour)
% Balances forces in region of contour point
%
% Usage: balanced forces= balance(xcoord,ycoord,edge image,current position in contour,whole contour)
               
nforces(1:3,1:3,1:2)=0;
[rows,cols]=size(edg);
%first work out the forces
for xx=x-1:x+1
    for yy=y-1:y+1
        if ((xx<cols+1)&&(xx>1))&&((yy<rows+1)&&(yy>1))
            xxx=xx-x+2;
            yyy=yy-y+2;
            forces(yyy,xxx,1)=Econt(xx,yy,pos,contour);
            forces(yyy,xxx,2)=Ecur(xx,yy,pos,contour);
        end
    end
end
%and then normalise them to lie between 0 and unity
mincont=min(min(forces(:,:,1)));
mincur=min(min(forces(:,:,2)));
maxcont=max(max(forces(:,:,1)));
maxcur=max(max(forces(:,:,2)));
for xx=1:3
    for yy=1:3
        nforces(yy,xx,1)=(forces(yy,xx,1)-mincont)/(maxcont-mincont);
        nforces(yy,xx,2)=(forces(yy,xx,2)-mincur)/(maxcur-mincur);
    end
end
