function [ feature ] = featureGenerationFor2Rec( rec1,rec2 )
%FEATUREGENERATION Summary of this function goes here
%   Detailed explanation goes here

%working in x direction only

intervals = flip(combnk([rec1(1) rec1(3) rec2(1) rec2(3)],2));
allenRel = [];
induRel = [];
maxAllenRel = 13;
% go through each pairwise intervals
for i = 1 : length(intervals)-1
    for j = i+1 : length(intervals)
        allenRel = [allenRel; computeTemporalRel(intervals(i,1),intervals(i,2), intervals(j,1),intervals(j,2))];
        %compute the INDU based on relative sizes of the two itervals
        if diff(intervals(i,:)) == diff(intervals(j,:))
            indu = maxAllenRel+1;
        elseif diff(intervals(i,:)) < diff(intervals(j,:))
            indu = maxAllenRel+2;
        else
            indu = maxAllenRel+3;
        end
        induRel = [induRel; indu];
    end
end
feature = [allenRel' induRel'];

end

