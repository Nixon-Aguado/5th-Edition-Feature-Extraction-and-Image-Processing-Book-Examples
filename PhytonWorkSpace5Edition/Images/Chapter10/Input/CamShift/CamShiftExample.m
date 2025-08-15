% CamShift Example
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
          
 % Region position
sizes = {     [15 8]
              [0 0]
              [0 0]
              [0 0]
              [0 0]
              [0 0] };         


% Density estimation parameter
filterSize = 1.0;

% Back projection parameter
backProjecionSize = .3;
serachSize = round(sizes{1}*1.5);
scaleResult = [1.5 .8];

% Compute initial density
q = Density(frames{1}, positions{1}, sizes{1}, filterSize);

% Position in next frame
for frameNum = 2: 6
    previousPos = [0 0];
    newPos = positions{frameNum-1};
    while(abs(previousPos(1)-newPos(1))+abs(previousPos(2)-newPos(2)) > 1)
        previousPos = newPos;
        newPos = MeanShift(frames{frameNum}, q, previousPos, sizes{frameNum-1}, filterSize);
    end
    positions{frameNum} = newPos;
    
    % Back project
    p = Density(frames{frameNum}, newPos, sizes{frameNum-1}, backProjecionSize);
    projected = BackProjection(frames{frameNum}, p); 
    [Crow, Ccolumn, Srow, Scolumn] = ComputeScale(projected, newPos, serachSize, scaleResult);
    sizes{frameNum} = [ Srow, Scolumn];
end

% Display frames
for frameNum = 1: 6
    result = DrawSquare(frames{frameNum},positions{frameNum},sizes{frameNum},0);
    figure(frameNum);
    image(result);
end
