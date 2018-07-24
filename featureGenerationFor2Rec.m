function [ feature ] = featureGenerationFor2Rec( rec1,rec2 )
%FEATUREGENERATION Given two rectangles in 2D as x1 y1 x2 y2 , compute
%core-9 [allen and corresponding indu] in X direction only.

%working in x direction only

intervals = flip(combnk([rec1(1) rec1(3) rec2(1) rec2(3)],2));
allenRel = {};
induRel = {};
% go through each pairwise intervals
for i = 1 : length(intervals)-1
    for j = i+1 : length(intervals)
        [~,Arel] = computeTemporalRel(intervals(i,1),intervals(i,2), intervals(j,1),intervals(j,2));
        allenRel = [allenRel; Arel];
        
        [~,Irel] = computeInduRel(intervals(i,1),intervals(i,2), intervals(j,1),intervals(j,2));
        induRel = [induRel;Irel];
    end       
end
feature = [allenRel' induRel'];

end

