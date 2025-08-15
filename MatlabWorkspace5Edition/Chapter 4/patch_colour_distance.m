function distance = patch_colour_distance(image,patch_size,x,y,xt,yt)
%Evaluates colour distance between two image patches
%used in context aware saliency
%
%  Usage: scalar = patch_colour_distance(image)
%
%  Parameters:  image      - coloured image
%               patch_size - size of patches for context (odd number)
%               x,y	       - coordinates of patch of interest
%               xt,yt	   - coordinates other patch

half=floor(patch_size/2)+1;
%distance=0;
distance=double(0);

for x1=1:patch_size   %evaluate over patch
    for y1=1:patch_size    %and over 3 colour bands
        distance=distance+double((image(y1+y-half,x1+x-half,1)-image(y1+yt-half,x1+xt-half,1))^2+...
                                 (image(y1+y-half,x1+x-half,2)-image(y1+yt-half,x1+xt-half,2))^2+...
                                 (image(y1+y-half,x1+x-half,3)-image(y1+yt-half,x1+xt-half,3))^2);
                                     %distance=distance+double((image(y-half+y1,x-half+x1,1)-image(yt+half+y1-1,xt+half+x1-1,1))^2+...
                                 %(image(y-half+y1,x-half+x1,2)-image(yt+half+y1-1,xt+half+x1-1,2))^2+...
                                 %(image(y-half+y1,x-half+x1,3)-image(yt+half+y1-1,xt+half+x1-1,3))^2);
    end
end
%and finish with Euclidean distance
distance=sqrt(distance)/(3*patch_size*patch_size);
end


