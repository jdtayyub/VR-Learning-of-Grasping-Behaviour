function [featTab,allData] = FlexMainFeatGeneration()
%FLEXMAINFEATGENERATION Main feature generation process with variable and
%any number of obstacles. Both in X and in Y. 
pathofdata = 'data2obstacleV1'; % enter data path here
files = dir(pathofdata);
features = [];
classes = {};

for f = 3 : length(files)
   tabread = readtable([pathofdata '/' files(f).name '/S001/trial_results.csv']);
   
   class = tabread.direction;
   objPos = tabread.position_rel;
   
end

end

