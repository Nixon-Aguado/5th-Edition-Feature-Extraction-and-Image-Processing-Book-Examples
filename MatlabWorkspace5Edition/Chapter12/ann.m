function class=ann(A,B,C,D)
threshold=25;
if A>threshold
    A=.5;
    else A=0;
end;
if B>threshold
    B=.5;
    else B=0;
end;
if C>threshold
    C=.5;
    else C=0;
end;
if D>threshold
    D=.5;
    else D=0;
end;
E= abs(A+B-C-D); %horizontal
F= abs(A+C-B-D); %vertical
G= abs(A+D-B-C); %diagonal
H= abs(A+B+C-D);  %corner
I= abs(-A+B+C+D); %corner
class(1)=E&&~F&&~G&&(~H+~I);
class(2)=~E&&F&&~G&&(~H+~I);
class(3)=~E&&~F&&G&&(~H+~I);
class(4)=E&&F&&G&&(H+I);
end