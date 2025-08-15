function template = non_square_ave(rows,cols)
%Non square averaging template for test pruposes only

%we'll normalise by the total sum
sum=0;

for i=1:cols
  for j=1:rows
    template(j,i)=1;
    sum=sum+template(j,i);
  end
end

template=template/sum;
