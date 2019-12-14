function img = signal2image(signal,varargin)
if nargin == 3
    signalSize = varargin{1};
    imageSize = varargin{2};
elseif nargin == 1
    signalSize = max(abs(real(signal)))*1.5;
    imageSize = 454;
else
    disp('Error: Number of input arguments shoud be (signal,signalSize,imageSize) or (signal)');
    return
end
img = zeros(imageSize);
for i = 1:length(signal)
    re = real(signal(i));
    im = imag(signal(i));
    imgx = round(imageSize/(2*signalSize)*(signalSize+re));
    imgy = round(imageSize/(2*signalSize)*(signalSize-im));
    if (imgx > imageSize)||(imgy > imageSize)
        continue
    end
    img(imgx,imgy) = 225;
end