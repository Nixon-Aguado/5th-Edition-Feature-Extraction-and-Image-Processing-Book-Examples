function entropy=calc_entropy(pic)
%get size of picture
[rows,cols]=size(pic);
%sum up entropy
entropy=0;
for x=1:cols
    for y=1:rows
        if pic(y,x)~=0
            entropy=entropy+pic(y,x)*log(pic(y,x));
        end
    end
end