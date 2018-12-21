function [indu,induC] = computeInduRel(is1,ie1,is2,ie2)
%COMPUTEINDUREL Basic indu relations, where relative lengths of two
%intervals decide on the corresponding qualitative relation as either being
%equal , larger or shorter
%   Detailed explanation goes here
% induC : string categorical variable

if diff([is1 ie1]) == diff([is2 ie2])
    indu = 1;
    induC = '=';
elseif diff([is1 ie1]) < diff([is2 ie2])
    indu = 2;
    induC = '<';
else
    indu = 3;
    induC = '>';
end

end

