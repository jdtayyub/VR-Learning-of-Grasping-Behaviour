function [ featTab,allData ] = MainFeatureGeneration( input_args )
%MAIN Summary of this function goes here
%   return feture data to be run with classifier
path = 'data';
files = dir(path);
features = [];
classes = {};
allData = [];
for f = 3 : length(files)
   tabread = readtable([path '/' files(f).name '/S001/trial_results.csv']);
   
   %%%Disable selection of example and practice trials
   tabread = tabread(find(~(ismember(tabread.condition,'Example') + ismember(tabread.condition,'Practice'))),:);
   %%%
   
   %%%Random Trials Only , Non-Random Trials Only or BOTH - ONLY ALLOW one
   %%%uncommented statement below
   %tabread = tabread(find(ismember(tabread.condition,'Random')),:);  % RANDOM TRIALS ONLY
   tabread = tabread(find(~ismember(tabread.condition,'Random')),:);  % NON-RANDOM TRIALS ONLY
                                                                    %COMMENT BOTH above command for BOTH                                                                      
   %%%%%%%%%%%%%%%%%%%%
   
   class = tabread.direction;
   objPos = tabread.position_rel;
   %Add condition filter whether random or not 
  
   x1 = repmat(-40,length(objPos),1); 
   x2 = ( objPos * 40 ) - 15;
   x3 = ( objPos * 40) + 15;
   x4 = repmat(40,length(objPos),1);
   feat = {};
   for i = 1 : length(x1)
     feat(i,:) = featureGenerationFor2Rec([x1(i) 0 x2(i) 0], [x3(i) 0 x4(i) 0]);
   end
   
   classes = [classes; class];
   features = [features; feat];
   allData = [allData;tabread];
end

%cleanup to get rid of empty class
remIdx = find(ismember(classes,''));
classes(remIdx) = [];
features(remIdx,:) = [];
allData(remIdx,:) = [];

%Create table of features
featTab = cell2table([features classes]);
featTab = varfun(@(x) categorical(x), featTab);
featTab.Properties.VariableNames(end) = {'class'}; % rename last column to class

end

