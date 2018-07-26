function [] = plotTrial(visualFile , posBlock)
%PLOT from input csv table with trial name and filename in directory of
%data
topDir = 'data';

v = readtable([topDir '/' visualFile{1}(5:end)]);
for i = 1 : size(v,1)
    
    
    plot(v.pos_x(i),v.pos_y(i),'o','MarkerEdgeColor','b')
    %plot(c.pos_x(i),c.pos_y(i),'o','MarkerEdgeColor','r')
    text(0,110,['Frame Number : ' num2str(i)]);
    hold on;
    axis([-55 55 -100 100]);
    rectangle('Position',[posBlock(1)-(30/2) posBlock(2)-(10/2) 30 10]);
    
    pause(0.02);
    
    hold off;
end

end

