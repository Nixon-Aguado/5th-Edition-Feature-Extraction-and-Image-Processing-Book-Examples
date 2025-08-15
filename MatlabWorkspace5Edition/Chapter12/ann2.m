function class=ann2(A,B,C,D,bias)
%call it with e.g. ann2(22,52,11,48,0.3)
E= abs(A+B-C-D); %horizontal
F= abs(A+C-B-D); %vertical
G= abs(A+D-B-C); %diagonal
H=max([A,B,C,D])/2;
J=1/(1+exp(-E/H))-bias;
K=1/(1+exp(-F/H))-bias;
L=1/(1+exp(-G/H))-bias;
if J>0.5 O=1; else O=0; end;
if K>0.5 P=1; else P=0; end;
if L>0.5 Q=1; else Q=0; end;
if J>0.5&&K>0.5 R=1; else R=0; end;
class(1)=O;
class(2)=P;
class(3)=Q;
class(4)=R;
end