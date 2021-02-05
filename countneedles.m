%needle detection

n = iread('20.PNG'); %ADD FILENAME
%% RGB planes
    nRed = n(:,:,1);
    nGreen = n(:,:,2);
    nBlue = n(:,:,3);
    %% Normalise planes
    nRedNormal = double(nRed)/255;
    nGreenNormal = double(nGreen)/255;
    nBlueNormal = double(nBlue)/255;
  
M = nRedNormal + nBlueNormal +nGreenNormal;
M = M>2 & M<2.8;
imshow(M);
k= waitforbuttonpress;
blobs = iblobs(M, 'area', [30, 1000], 'boundary');
blobcount = 0; 
for i=1: length(blobs)
    if (blobs(i).parent ~= 80)&(blobs(i).parent ~= 0)
    blobs(i).plot('r*');
    blobcount = blobcount+1;
    end
end
k= waitforbuttonpress;
fprintf('there are %d needles',blobcount);