function distance=dvE(vec1,vec2) %evaluate Euclidean distance

[rows,cols]=size(vec1);
distance=0;
for i=1:cols %for all vector elements
    distance=distance+(vec1(i)-vec2(i))*(vec1(i)-vec2(i));
end
distance=sqrt(distance);
    