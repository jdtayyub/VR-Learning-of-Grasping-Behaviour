function [rel,relC] = computeTemporalRel(is1,ie1,is2,ie2)
 
rel = '';
 
if is2-1 == ie1
    rel = 2; %'meets'
    relC = 'm';
    
elseif is1-1 == ie2
    rel = 11;%'metby' inverse
    relC = 'mi';
    
elseif is1 == is2 && ie1 == ie2
        rel = 13;%'equal'
        relC = 'e';
        
elseif is2 > ie1
        rel = 1;%'before'
        relC = 'b';
        
elseif is1 > ie2
        rel = 12;%'after'
        relC = 'a';
        
elseif ie1 >= is2 && ie1 < ie2 && is1 < is2
        rel =  3;%'overlaps'
        relC = 'o';
        
elseif ie2 >= is1 && ie2 < ie1 && is2 < is1
        rel = 10;%'overlapped_by'
        relC = 'oi';
        
elseif is1 > is2 && ie1 < ie2
        rel =  5;%'during'
        relC = 'd';
        
elseif is1 < is2 && ie1 > ie2
        rel =  8;%'contains'
        relC = 'c';
        
elseif is1 == is2 && ie1 < ie2
        rel =  4;%'starts'
        relC = 's';
        
elseif is1 == is2 && ie1 > ie2
        rel =  9;%'started_by'
        relC = 'si';
        
elseif ie1 == ie2 && is2 < is1
        rel =  6;%'finishes'
        relC = 'f';
        
elseif ie1 == ie2 && is2 > is1
        rel =  7;%'finished_by'
        relC = 'fi';
end
 
 
 
end
