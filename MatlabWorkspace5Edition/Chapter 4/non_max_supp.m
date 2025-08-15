function peaks = non_max_supp(edges)
% New image point brightness = peaks of Sobel data
%
%  Usage: [new image] = non_max_supp(edges)
%
%  Parameters: input images from Sobel_edges [xmag, ymag, mag]

%get dimensions
[rows,cols]=size(edges(:,:,1));

%set the output image to black (0)
peaks(1:rows,1:cols)=0;

%then get differentiation perpendicular to the edge
for x = 2:cols-1 %address all columns except border
  for y = 2:rows-1 %address all rows except border
      uxs=edges(y,x,1);
	  uys=edges(y,x,2);
	  ux=abs(uxs);
	  uy=abs(uys); %now do the 4 quadrants
	  if ((uxs>=0)&&(uys>=0))||((uxs<0)&&(uys<0))
          cor1=edges(y+1,x+1,3); 
          cor2=edges(y-1,x-1,3);
          if (ux>=uy)%quadrant 1
              mid1=edges(y+1,x,3); % Eqs. 4.22 and 4.23
              mid2=edges(y-1,x,3);
              grad=ux*edges(y,x,3); %now interpolate
              grad1=uy*cor1+(ux-uy)*mid1;
              grad2=uy*cor2+(ux-uy)*mid2;
          else %quadrant 2
              mid1=edges(y,x+1,3); 
              mid2=edges(y,x-1,3);
              grad=uy*edges(y,x,3); %now interpolate
              grad1=ux*cor1+(uy-ux)*mid1;
              grad2=ux*cor2+(uy-ux)*mid2;
          end
      else
          cor1=edges(y-1,x+1,3);
          cor2=edges(y+1,x-1,3);
          if (ux>=uy) %quadrant 3
              mid1=edges(y-1,x,3);
              mid2=edges(y+1,x,3);
              grad=ux*edges(y,x,3); %now interpolate
              grad1=uy*cor1+(ux-uy)*mid1;
              grad2=uy*cor2+(ux-uy)*mid2;
          else %quadrant 4
              mid1=edges(y,x+1,3);
              mid2=edges(y,x-1,3);
              grad=uy*edges(y,x,3); %now interpolate
              grad1=ux*cor1+(uy-ux)*mid1;
              grad2=ux*cor2+(uy-ux)*mid2;
          end
      end %now keep point if maximum
      if ((grad>grad1)&&(grad>grad2))
          peaks(y,x)=edges(y,x,3);
      else %set it to zero
          peaks(y,x)=0;
      end
  end
end
