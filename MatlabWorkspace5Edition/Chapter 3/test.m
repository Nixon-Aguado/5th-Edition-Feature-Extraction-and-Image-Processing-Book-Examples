function gradient= test(rows,cols)
%image for test purposes only

gradient(1:rows,1:cols)=0;

%generate brightness unique to each point
for i=1:cols
  for j=1:rows
    gradient(j,i)=i*j+i+j*j;
  end
end

