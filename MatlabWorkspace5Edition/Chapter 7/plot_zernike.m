r=linspace(0,1,100);
hold off
%change order
p20=2.*r.*r-1;
plot(r,p20)
hold on
p40=6.*r.*r.*r.*r-6.*r.*r+1;
plot(r,p40)
p60=20.*r.*r.*r.*r.*r.*r-30.*r.*r.*r.*r+12.*r.*r-1;
plot(r,p60)
p80=70.*r.*r.*r.*r.*r.*r.*r.*r-140.*r.*r.*r.*r.*r.*r+90.*r.*r.*r.*r-20.*r.*r+1;
plot(r,p80)
hold off
%change repetition
p60=20.*r.*r.*r.*r.*r.*r-30.*r.*r.*r.*r+12.*r.*r-1;
plot(r,p60)
hold on
p62=15.*r.*r.*r.*r.*r.*r-20.*r.*r.*r.*r+6.*r.*r;
plot(r,p62)
z64=6.*r.*r.*r.*r.*r.*r-5.*r.*r.*r.*r;
plot(r,z64)
p66=r.*r.*r.*r.*r.*r;
plot(r,p66)
%now let's get a surface
int=100;
z40(1:int,1:int)=0;
z60(1:int,1:int)=0;
z64(1:int,1:int)=0;
for x=1:int
    for y=1:int
        xd=(x-1)/int;
        yd=(y-1)/int;
        if ((xd*xd+yd*yd)<0.999)
            z40(y,x)=6*yd*yd*yd*yd+12*xd*xd*yd*yd+6*xd*xd*xd*xd-6*yd*yd-6*xd*xd+1;
            z60(y,x)=20*yd*yd*yd*yd*yd*yd+60*xd*xd*yd*yd*yd*yd+60*xd*xd*xd*xd*yd*yd+20*xd*xd*xd*xd*xd*xd-30*yd*yd*yd*yd-60*xd*xd*yd*yd-30*xd*xd*xd*xd+12*yd*yd+12*xd*xd-1;
            z64(y,x)=6*xd*xd*xd*xd*xd*xd-30*xd*xd*xd*xd*yd*yd-30*xd*xd*yd*yd*yd*yd+6*yd*yd*yd*yd*yd*yd-5*xd*xd*xd*xd+30*xd*xd*yd*yd-5*yd*yd*yd*yd;
        end
    end
end
%copy the quadrants
z64(1:int,1:int)=z64(int:-1:1,int:-1:1);
z64(int+1:2*int,int+1:2*int)=z64(int:-1:1,int:-1:1);
z64(int+1:2*int,1:int)=z64(int:-1:1,1:int);
z64(1:int,int+1:2*int)=z64(1:int,int:-1:1);
