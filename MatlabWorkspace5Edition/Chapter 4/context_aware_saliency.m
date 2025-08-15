function map = context_aware_saliency(image,patch_size,searchsize)
%New image point brightness = context aware saliency of image data
%
%  Usage: new image = context_aware_saliency(image,local patch,image patch)
%
%  Parameters:  image      - coloured image (RGB)
%               patch_size - size of patches for context (odd, integer)
%               searchsize - size of search area (odd, integer)


%get dimensions
[rows,cols]=size(image(:,:,1));

%and initialise map
map(1:rows,1:cols)=0;

%convert image to CIE colour space
image=rgb2xyz(image);

%define the number of scales
no_of_scales=4;

%work out the saliency over all scales
for scale=1:no_of_scales
    %half of template is
    half=floor(scale*patch_size/2)+1; 
    %and half of the scale*search
    halfsearch=floor(scale*searchsize/2)+1;
    
    %check window function
    if patch_size>searchsize
        patch_size=searchsize-1; %failure case
        disp ('That would fail so to save blushes we have reset patchsize to be')
        patch_size
    end
    
    border=halfsearch;
    
    %set the number of matches to 64
    K=64;
    
    %intitialise the matches to zero
    matches(1:K,1:2)=0;

    %initialise the maximium match
    minimum=0;
    
    %use the image size for normalisation
    %maxdist=sqrt(cols*cols+rows*rows);
    
    %we start by looking at all image points except those in the border
    for x = border:scale:cols-border+1 %look at patches based on image points
      for y = border:scale:rows-border+1 
          for iwin = x-halfsearch+half:scale:x+halfsearch-half-1 %compare with patches based on all other image points
              for jwin = y-halfsearch+half:scale:y+halfsearch-half-1
                  if (x~=iwin)&&(y~=jwin) % don't compare the same points
                      % evaluate colour distance, Eq. 4.82
                      dcolour=patch_colour_distance(image,patch_size,x,y,iwin,jwin);
                      % keep the K best dissimilarities
                      if dcolour>minimum
                         matches=stickitin(matches,dcolour,x,y,iwin,jwin,K);
                      end
                      %now reset the trigger
                      minimum=min(matches(:,1));
                  end
              end
          end
          %now work out the saliency
          %first normalise the colour distances
          %matches(:,1)=matches(:,1)/max(matches(:,1));
          %and the distances
          %matches(:,2)=matches(:,2)/maxdist;
      %initialise sum of the distances
      summup=0;
      %evaluate the single scale saliency
      for i=1:K %Eq. 4.83
          summup=summup+(matches(i,1)/(1+3*matches(i,2)));
      end
      for i=1:scale
          for j=1:scale %Eq. 4.84
              map(y+j,x+i)=map(y+j,x+i)+(1-exp(-summup/K));
          end
      end
      %clear the matches
      matches(:,:)=0;
      %initialise the maximum match
      minimum=0;
      end
    end
end
