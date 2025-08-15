function pos=coord(value,data_sample)
[rows,cols]=size(data_sample);
for i=1:cols
    if value==data_sample(i)
        pos=i;
    end
end