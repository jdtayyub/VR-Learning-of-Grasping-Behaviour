function [ flag ] = intersection( rec1 , rec2 )
%INTERSECTION Returns boolean checking intersection of rectangles

% The function takes in x y w h , whereas the input is in x1 y1 x2 y2 so
% the following code performs this converison

Trec1 = [rec1(1) rec1(2) rec1(3)-rec1(1) rec1(4)-rec1(2)];
Trec2 = [rec2(1) rec2(2) rec2(3)-rec2(1) rec2(4)-rec2(2)];

if rectint(Trec1,Trec2)>0
    flag= true;
else
    flag= false;
end

end

