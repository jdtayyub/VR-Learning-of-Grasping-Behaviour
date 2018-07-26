function [trainedClassifier, validationAccuracy] = trainClassifierMediumTree(trainingData)
% [trainedClassifier, validationAccuracy] = trainClassifier(trainingData)
% returns a trained classifier and its accuracy. This code recreates the
% classification model trained in Classification Learner app. Use the
% generated code to automate training the same model with new data, or to
% learn how to programmatically train models.
%
%  Input:
%      trainingData: a table containing the same predictor and response
%       columns as imported into the app.
%
%  Output:
%      trainedClassifier: a struct containing the trained classifier. The
%       struct contains various fields with information about the trained
%       classifier.
%
%      trainedClassifier.predictFcn: a function to make predictions on new
%       data.
%
%      validationAccuracy: a double containing the accuracy in percent. In
%       the app, the History list displays this overall accuracy score for
%       each model.
%
% Use the code to train the model with new data. To retrain your
% classifier, call the function from the command line with your original
% data or new data as the input argument trainingData.
%
% For example, to retrain a classifier trained with the original data set
% T, enter:
%   [trainedClassifier, validationAccuracy] = trainClassifier(T)
%
% To make predictions with the returned 'trainedClassifier' on new data T2,
% use
%   yfit = trainedClassifier.predictFcn(T2)
%
% T2 must be a table containing at least the same predictor columns as used
% during training. For details, enter:
%   trainedClassifier.HowToPredict

% Auto-generated by MATLAB on 24-Jul-2018 15:17:04


% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
predictorNames = {'Fun_Var1', 'Fun_Var2', 'Fun_Var3', 'Fun_Var4', 'Fun_Var5', 'Fun_Var6', 'Fun_Var7', 'Fun_Var8', 'Fun_Var9', 'Fun_Var10', 'Fun_Var11', 'Fun_Var12', 'Fun_Var13', 'Fun_Var14', 'Fun_Var15', 'Fun_Var16', 'Fun_Var17', 'Fun_Var18', 'Fun_Var19', 'Fun_Var20', 'Fun_Var21', 'Fun_Var22', 'Fun_Var23', 'Fun_Var24', 'Fun_Var25', 'Fun_Var26', 'Fun_Var27', 'Fun_Var28', 'Fun_Var29', 'Fun_Var30'};
predictors = inputTable(:, predictorNames);
response = inputTable.class;
isCategoricalPredictor = [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true];

% Train a classifier
% This code specifies all the classifier options and trains the classifier.
classificationTree = fitctree(...
    predictors, ...
    response, ...
    'SplitCriterion', 'gdi', ...
    'MaxNumSplits', 20, ...
    'Surrogate', 'off', ...
    'ClassNames', categorical({'DetectNeg'; 'DetectPos'}));

% Create the result struct with predict function
predictorExtractionFcn = @(t) t(:, predictorNames);
treePredictFcn = @(x) predict(classificationTree, x);
trainedClassifier.predictFcn = @(x) treePredictFcn(predictorExtractionFcn(x));

% Add additional fields to the result struct
trainedClassifier.RequiredVariables = {'Fun_Var1', 'Fun_Var2', 'Fun_Var3', 'Fun_Var4', 'Fun_Var5', 'Fun_Var6', 'Fun_Var7', 'Fun_Var8', 'Fun_Var9', 'Fun_Var10', 'Fun_Var11', 'Fun_Var12', 'Fun_Var13', 'Fun_Var14', 'Fun_Var15', 'Fun_Var16', 'Fun_Var17', 'Fun_Var18', 'Fun_Var19', 'Fun_Var20', 'Fun_Var21', 'Fun_Var22', 'Fun_Var23', 'Fun_Var24', 'Fun_Var25', 'Fun_Var26', 'Fun_Var27', 'Fun_Var28', 'Fun_Var29', 'Fun_Var30'};
trainedClassifier.ClassificationTree = classificationTree;
trainedClassifier.About = 'This struct is a trained model exported from Classification Learner R2018a.';
trainedClassifier.HowToPredict = sprintf('To make predictions on a new table, T, use: \n  yfit = c.predictFcn(T) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedModel''. \n \nThe table, T, must contain the variables returned by: \n  c.RequiredVariables \nVariable formats (e.g. matrix/vector, datatype) must match the original training data. \nAdditional variables are ignored. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appclassification_exportmodeltoworkspace'')">How to predict using an exported model</a>.');

% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
predictorNames = {'Fun_Var1', 'Fun_Var2', 'Fun_Var3', 'Fun_Var4', 'Fun_Var5', 'Fun_Var6', 'Fun_Var7', 'Fun_Var8', 'Fun_Var9', 'Fun_Var10', 'Fun_Var11', 'Fun_Var12', 'Fun_Var13', 'Fun_Var14', 'Fun_Var15', 'Fun_Var16', 'Fun_Var17', 'Fun_Var18', 'Fun_Var19', 'Fun_Var20', 'Fun_Var21', 'Fun_Var22', 'Fun_Var23', 'Fun_Var24', 'Fun_Var25', 'Fun_Var26', 'Fun_Var27', 'Fun_Var28', 'Fun_Var29', 'Fun_Var30'};
predictors = inputTable(:, predictorNames);
response = inputTable.class;
isCategoricalPredictor = [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true];

% Perform cross-validation
partitionedModel = crossval(trainedClassifier.ClassificationTree, 'KFold', 2);

% Compute validation predictions
[validationPredictions, validationScores] = kfoldPredict(partitionedModel);

% Compute validation accuracy
validationAccuracy = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');