% Load Image into workspace (image is m*n*3 array)
function [im]= loadimage(picID)
    dir = 'C:\Users\ryanj\Documents\MATLAB\EGB339\RobotVision\'; %can be different directory
    id = int2str(picID);
    jpg = '.jpg';
    pic = [dir id jpg];
    im = iread(pic);
end