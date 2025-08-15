function inertia=calc_inertia(pic)
%get size of picture
[rows,cols]=size(pic);
%sum up energy
inertia=0;
for x=1:cols
    for y=1:rows
        inertia=inertia+(x-y)*(x-y)*pic(y,x);
    end
end