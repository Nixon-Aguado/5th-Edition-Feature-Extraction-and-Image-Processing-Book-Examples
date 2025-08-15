function energy=calc_energy(pic)
%get size of picture
[rows,cols]=size(pic);
%sum up energy
energy=0;
for x=1:cols
    for y=1:rows
        energy=energy+pic(y,x)*pic(y,x);
    end
end