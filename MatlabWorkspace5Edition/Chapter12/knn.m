function test_class=knn(test, data, value_k, no)
[rows,cols]=size(data);
%use odd values of k and given data structure only
%first work out the distances from test to other classes
for i=1:rows
    dists(i)=dvE(test,data(i,:));
end
minim(1:value_k)=0; %now which are the k best matches
for s=1:value_k
    posmin=coord(min(dists),dists); %find the best 
    minim(s)=posmin;  %and store its position
    dists(posmin)=max(dists)+1; %clear the best 
end
fsp=rows/no; %size of classes in data
class(1:no)=0;
for i=1:value_k %look at all k minima
    for j=1:no %and all classes
        %check if within a class partition
        if ((minim(i)>=(j-1)*fsp+1)&&(minim(i)<(j*fsp+1)))
            class(j)=class(j)+1; %if so, increment class
        end
    end
end
[rowsc,colsc]=size(class);
no_unique_class=0; %check class label is unique
for i=1:colsc %look at all classes
    for j=i+1:colsc %upper half of matrix
        if (class(i)>0)&&(class(i)==class(j)) %check similarity
            no_unique_class=1; %if so, set flag
        end
    end
end
if no_unique_class %if two class labels same
    test_class=knn(test,data,value_k-2,no) %call knn with k=k-2
else
    test_class=coord(max(class),class); %return maximum class
end
    
    