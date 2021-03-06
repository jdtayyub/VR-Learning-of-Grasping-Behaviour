function [ state ] = computeState( recID1, coords1, recID2, coords2  )
%COMPUTESTATE Function computes the 9-tuple state of the 9 cores between
%rectangle with id 1 and rectangle with id 2 and their corresponding
%[x1,y1,x2,y2] positions.

state = {};

Sx1 = coords1(1); Sx2 = coords2(1); Ex1 = coords1(3); Ex2 = coords2(3);
Sy1 = coords1(2); Sy2 = coords2(2); Ey1 = coords1(4); Ey2 = coords2(4);

cores = []; % coordinates of all cores
cores(1) = [Sx1 Sy2 Sx2 Sy1];
cores(2) = [Sx2 Sy2 Ex1 Sy1];
cores(3) = [Ex1 Sy2 Ex2 Sy1];
cores(4) = [Sx1 Sy1 Sx2 Ey2];
cores(5) = [Sx2 Sy1 Ex1 Ey2];
cores(6) = [Ex1 Sy1 Ex2 Ey2];
cores(7) = [Sx1 Ey2 Sx2 Ey1];
cores(8) = [Sx2 Ey2 Ex1 Ey1];
cores(9) = [Ex1 Ey2 Ex2 Ey1];

for i = 1 : length(cores)
    if isPoint(cores(i)) || isLine(cores(i))
        state(i) = 'phi';
    elseif intersect(cores(i),coords1) && intersection(cores(i),coords2) %core intersection with first and second rect
        state(i) = sprintf('%s,%s',recID1,recID2);
    elseif intersection(cores(i),coords1) %core intersection with first rect only
        state(i) = sprintf('%s',recID1);
    elseif intersection(cores(i),coords1) %core intersection with second rect only
        state(i) = sprintf('%s',recID2);
    else % no intersection with anything
        state(i) = 'null';
    end
end

end

