%% A function that inputs the desired colour to detect and outputs an binary image
%% 
function [image_]= ColourDetect(picID, gamma, threshold, colour)
    %% Getting the pictures


    im = imread(picID);
    
    %% RGB planes
    imRed = im(:,:,1);
    imGreen = im(:,:,2);
    imBlue = im(:,:,3);
    %% Normalise planes
    imRedNormal = double(imRed)/255;
    imGreenNormal = double(imGreen)/255;
    imBlueNormal = double(imBlue)/255;
    %% Gamma Correct 
    imR = imRedNormal.^gamma;
    imG = imGreenNormal.^gamma;
    imB = imBlueNormal.^gamma;
    %% Chromaticity
    imr = imR./(imR+imG+imB);
    img = imG./(imR+imG+imB);
    imb = imB./(imR+imG+imB);
    %% Threshold
    imrThings = imr>threshold;
    imgThings = img>threshold;
    imbThings = imb>threshold;
    %% Display
    if strcmp(colour, 'red')
        image_ = imrThings;
        imshow(imrThings);
    
    elseif strcmp(colour, 'green')
        image_ = imgThings;
        imshow(imgThings);
    
    elseif strcmp(colour, 'blue')
        image_ = imbThings;
        imshow(imbThings);
    elseif strcmp(colour, 'all')
        image_ = imbThings+imgThings+imrThings;
    else
        error('Not a valid colour');
    end
    

end
    

    