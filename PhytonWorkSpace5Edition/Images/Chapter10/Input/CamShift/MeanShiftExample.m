% MeanShift Example
clear;

% Read image data
frames = {imread('sequence\frame1.bmp','bmp'),
          imread('sequence\frame2.bmp','bmp'),
          imread('sequence\frame3.bmp','bmp'),
          imread('sequence\frame4.bmp','bmp'),
          imread('sequence\frame5.bmp','bmp'),
          imread('sequence\frame6.bmp','bmp')}; 
      
% Region position
positions = { [60 100]
              [0 0]
              [0 0]
              [0 0]
              [0 0]
              [0 0] };


% Density estimation parameter
filterSize = 1.0;

% Radius from the centre (rows,columns)
regionSize = [ 15 8 ];

% Compute initial density
q = Density(frames{1}, positions{1}, regionSize, filterSize);

% Position in next frame
for frameNum = 2: 6
    previousPos = [0 0];
    newPos = positions{frameNum-1};
    while(abs(previousPos(1)-newPos(1))+abs(previousPos(2)-newPos(2)) > 1)
        previousPos = newPos;
        newPos = MeanShift(frames{frameNum}, q, previousPos, regionSize, filterSize);
    end
    positions{frameNum} = newPos;
end

% Display frames
for frameNum = 1: 6
    result = DrawSquare(frames{frameNum},positions{frameNum},regionSize,0);
    figure(frameNum);
    image(result);
end
