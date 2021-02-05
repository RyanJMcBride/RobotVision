%%  Function to find blobs and label them
% [a1, a2] is the limits of blob area, usually [2000, 25000]
% boxcol is bounding box colour scheme
function [blobs] = FindBlobs(im, a1, a2, boxcol)

b = iblobs(im, 'area', [a1, a2], 'boundary', 'aspect', [0.6,1]);

for i=1:length(b)
    if boxcol == 1
    b(i).plot('r*');
    b(i).plot_box('g');
    elseif boxcol ==2
    b(i).plot('r*');
    b(i).plot_box('b');
    end
    %b(i).plot_ellipse('b');
%     
%     if b(i).circularity > 0.9
%         fprintf('Red shape ID %d is a Circle\n', i );
%        
%    elseif b(i).circularity > 0.6
%         fprintf('Red shape ID %d is a Square\n', i );
%         
%     elseif b(i).circularity > 0.45
%         fprintf('Red shape ID %d is a Triangle\n', i );
%     else
%         fprintf('Red shape ID %d is of an unknown type\n', i );
%     end
end

end