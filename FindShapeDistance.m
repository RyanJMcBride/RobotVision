function [x,y]= FindShapeDistance(size, colour, shape, b, g, r);

%Set the search colour
if strcmpi(colour, 'red');   
    searchcolour = r;  


elseif strcmpi(colour, 'green');   
    searchcolour = g;  
end


%

if length (r) == 6 && length (g) == 6;   
circboundr = r.circularity;
circboundr = sort(circboundr);
circboundg = g.circularity;
circboundg = sort(circboundg);
tribound = min(circboundr(3),circboundg(3)) - 0.0001;
circbound = min(circboundr(5), circboundg(5)) - 0.001;

else
tribound = 0.65;
circbound = 0.9;
end



% Set the parameters for circularity depending on input shape
if strcmpi(shape, 'circle');
    upperbound = 2;
    lowerbound = circbound;    


elseif strcmpi(shape, 'square');
    upperbound = circbound;
    lowerbound = tribound;    



elseif strcmpi(shape, 'triangle');
    upperbound = tribound;
    lowerbound = 0.45;    
end

%Find the average area for the shape we are looking for. Considering both
%colours.
k = 0;
totalarea = 0;
for i=1:length(r);
    if (r(i).circularity > lowerbound && r(i).circularity < upperbound);
        k = k+1;
        totalarea = totalarea + r(i).area;        
    end    
end

for i=1:length(g);
    if (g(i).circularity > lowerbound && g(i).circularity < upperbound);
        k = k+1;
        totalarea = totalarea + g(i).area;        
    end    
end

averagearea = totalarea/k;

%now we search for the shape we want.
foundlocation = 0;

for i=1:length(searchcolour);
    if (searchcolour(i).circularity > lowerbound & searchcolour(i).circularity < upperbound);
       
        if strcmpi(size, 'large')
            if searchcolour(i).area > averagearea;
                foundlocation = i;
            end            
        end
        
        if strcmpi(size, 'small')
            if searchcolour(i).area < averagearea;
                foundlocation = i;
            end
        end       
        
        
    end    
end




% Get coords of blue circle centroids
for i=1:length(b);
    Pb(1,i) = b(i).uc;
    Pb(2,i) = b(i).vc;
end

%Get the order the blue circles have been found in 
for i=1:3;
    
    if Pb(1,i) == min(Pb(1,1:3));
    [Y,order(1)] = min(Pb(1,1:3));
    elseif Pb(1,i) == max(Pb(1,1:3));
    [Y,order(3)] = max(Pb(1,1:3));
    else 
    order(2) = i;
    end
end

for i=4:6;
    
    if Pb(1,i) == min(Pb(1,4:6));
    [Y,L] = min(Pb(1,4:6));
    order(4) = L + 3 ;
    elseif Pb(1,i) == max(Pb(1,4:6));
    [Y,L] = max(Pb(1,4:6));
    order(6) = L + 3;
    else 
    order(5) = i;
    end
end

for i=7:9;
    
    if Pb(1,i) == min(Pb(1,7:9));
    [Y,L] = min(Pb(1,7:9));
    order(7) = L + 6;
    elseif Pb(1,i) == max(Pb(1,7:9));
    [Y,L] = max(Pb(1,7:9));
    order(9) = L + 6;
    else 
    order(8) = i;
    end
end

%Re-get the coordinates of the blue circle centroids in an order that
%matches top-to-bottom left-to-right

for i=1:length(b);
    Pb(1,i) = b(order(i)).uc;
    Pb(2,i) = b(order(i)).vc;
end



%real locations of the blue circle from left to right, top to bottom


Q = [20 380; 200 380; 380 380; 20 200; 200 200; 380 200; 20 20; 200 20; 380 20];

H = homography(Pb, Q');



% Find real-world coordinates of red shapes

  p = [searchcolour(foundlocation).uc searchcolour(foundlocation).vc];
  q = homtrans(H,p');
  fprintf('The %s %s %s is at %.2f100mm in the x direction and %.2f100mm in the y direction from origin\n',size, colour, shape, q(1), q(2));

    x = q(1);
    y = q(2);

end