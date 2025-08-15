function dist=histogram_intersection(vec1,vec2)
%evaluate the histogram_intersection  between two histograms (stored as vectors)
[rows,cols]=size(vec1);
sum1=0;
sum2=0;
for k=1:cols
    sum1=sum1+vec1(k);
    sum2=sum2+vec2(k);
end
dist=0;
for k=1:cols
    dist=dist+min(vec1(k)/sum1, vec2(k)/sum2);
end
