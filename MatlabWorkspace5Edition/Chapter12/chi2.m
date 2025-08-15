function dist=chi2(vec1,vec2);
%evaluate the chi2 distance between two histograms (stored as vectors)
[rows,cols]=size(vec1);
dist=0;
for k=1:cols
    if vec1(k)==0&&vec2(k)==0
        dist=dist+0;
    else
        dist=dist+((vec1(k)-vec2(k))^2/(vec1(k)+vec2(k)));
    end
end

    
