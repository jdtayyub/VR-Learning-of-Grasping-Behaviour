function [ FeatureData ] = main( input_args )
%MAIN Summary of this function goes here
%   return feture data to be run with classifier
path = 'data';
files = dir(path);
features = [];
classes = {};
allData = [];
for f = 3 : length(files)
   tabread = readtable([path '/' files(f).name '/S001/trial_results.csv']);
   class = tabread.direction;
   objPos = tabread.position_rel;
   %Add condition filter whether random or not 
  
   x1 = repmat(-40,length(objPos),1); 
   x2 = ( objPos * 40 ) - 15;
   x3 = ( objPos * 40) + 15;
   x4 = repmat(40,length(objPos),1);
   feat = [];
   for i = 1 : length(x1)
     feat(i,:) = featureGenerationFor2Rec([x1(i) 0 x2(i) 0], [x3(i) 0 x4(i) 0]);
   end
   
   classes = [classes; class];
   features = [features; feat];
   allData = [allData;tabread];
end

%cleanup to get rid of empty class
classNum = zeros(length(classes),1);
remIdx = find(ismember(classes,''));
classes(remIdx) = [];
features(remIdx,:) = [];
allData(remIdx,:) = [];
% map classes to numbers
classNum = ismember(classes,'DetectPos');

%convert categorical to nominal using one hot encoding
encodedFeature = featureCategoricalToBinaryNumerical(features, 1:max(max(features) ));

FeatureData = [encodedFeature classNum];



end

