function [foundlocation, searchcolour]= FindShapeLocation(size, colour, shape, b, g, r)

%Set the search colour
if strcmpi(colour, 'red')   
    searchcolour = r;  


elseif strcmpi(colour, 'green')   
    searchcolour = g;  
end



if length (r) == 6 && length (g) == 6   
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
if strcmpi(shape, 'circle')
    upperbound = 2;
    lowerbound = circbound;    


elseif strcmpi(shape, 'square')
    upperbound = circbound;
    lowerbound = tribound;    



elseif strcmpi(shape, 'triangle')
    upperbound = tribound;
    lowerbound = 0.45;    
end

%Find the average area for the shape we are looking for. Considering both
%colours.
k = 0;
totalarea = 0;
for i=1:length(r)
    if (r(i).circularity > lowerbound && r(i).circularity < upperbound);
        k = k+1;
        totalarea = totalarea + r(i).area;        
    end    
end

for i=1:length(g)
    if (g(i).circularity > lowerbound && g(i).circularity < upperbound);
        k = k+1;
        totalarea = totalarea + g(i).area;        
    end    
end

averagearea = totalarea/k;

%now we search for the shape we want.
foundlocation = 0;

for i=1:length(searchcolour)
    if (searchcolour(i).circularity > lowerbound & searchcolour(i).circularity < upperbound);
       
        if strcmpi(size, 'large')
            if searchcolour(i).area > averagearea
                foundlocation = i;
            end            
        end
        
        if strcmpi(size, 'small')
            if searchcolour(i).area < averagearea
                foundlocation = i;
            end
        end       
        
        
    end    
end



end