function matches = stickitin(matches,dcolour,x,y,x1,y1,K)
%Inserts new element into K best matches
%used in context aware saliency
%
%  Usage: [new best matches]  = stickitin(matches,dcolour,K))
%
%  Parameters:  matches      - K best matches
%               dcolour		 - distance of current match
%               x,y,x1,y1    - coordinates patches
%               K			 - no of patches

%set variable to stop the shifting once the new value is inserted
finished=0;

%store maximum at matches(K)
for k=K:-1:1
    if (dcolour>matches(k)&&finished==0)
        %if we have a bigger one, shift the smaller ones
        for kk=2:k
            matches(kk-1,1)=matches(kk,1);
            matches(kk-1,2)=matches(kk,2);
        end
        %and insert the bigger one
        matches(k,1)=dcolour;
        %store the Euclidean distance beween the points
        matches(k,2)=sqrt((x-x1)^2+(y-y1)^2);
        %and switch everything off
        finished=1;
    else %if it's the same ignore it
        if dcolour==matches(k,1)
            dcolour=0;
        end
    end
end





