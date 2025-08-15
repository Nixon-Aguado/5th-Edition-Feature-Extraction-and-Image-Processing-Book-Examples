function histo=calc_hist(pic)
%to get round Matlab's crap histogram functions for LBP
%get size of picture
[rows,cols]=size(pic);

histo(1:10)=0;
for x=1:cols
    for y=1:rows
        histo(pic(y,x)+1)=histo(pic(y,x)+1)+1;
    end
end

        