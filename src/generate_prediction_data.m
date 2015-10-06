%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test the Neural Net
% The OMTM is "test error"
% If this goes down, then we've done something good.
%
% Compute accuracy for the training, cross validation and test sets.
% Compute error for the training, cross validation and test sets.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialization
close all; clc


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Files that get written ...
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% READING ...
weightsMatLabFile            = [getenv("FLERE_IMSAHO") "/data/matlab/flere-imsaho-weights.mat"];

trainingSetCsvFile   = [getenv("FLERE_IMSAHO") "/data/playlists/output/training-set.csv"];
validationSetCsvFile = [getenv("FLERE_IMSAHO") "/data/playlists/output/validation-set.csv"];
testSetCsvFile       = [getenv("FLERE_IMSAHO") "/data/playlists/output/test-set.csv"];

%matlabTrainingFile   = fullfile(getenv("FLERE_IMSAHO"), "data/matlab", "flere-imsaho-train.mat");
%matlabValidationFile = fullfile(getenv("FLERE_IMSAHO"), "data/matlab", "flere-imsaho-val.mat");
%matlabTestFile       = fullfile(getenv("FLERE_IMSAHO"), "data/matlab", "flere-imsaho-test.mat");

% WRITING ...
trainingSetPredictionsCsvFile    = [getenv("FLERE_IMSAHO") "/data/playlists/output/training-set-predictions.csv"];
validationSetPredictionsCsvFile  = [getenv("FLERE_IMSAHO") "/data/playlists/output/validation-set-predictions.csv"];
testSetPredictionsCsvFile        = [getenv("FLERE_IMSAHO") "/data/playlists/output/test-set-predictions.csv"];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NOTE
% This script requires that the data has already been loaded into global variables
% for processing.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

loadData;

global Xtrain;
global ytrain;
global Xval;
global yval;
global Xtest;
global ytest;

% Load the neural network parameters that were trained in trainNN.m
% variables Theta1 and Theta2 should now contain the weights
load(weightsMatLabFile);

[pTrain pTrainProb1 pTrainProb2] = predict(Theta1, Theta2, Xtrain);
[pVal pValProb1 pValProb2]       = predict(Theta1, Theta2, Xval);
[pTest pTestProb1 pTestProb2 ]   = predict(Theta1, Theta2, Xtest);

fprintf('Training Set Accuracy:    %f\n', mean(double(pTrain == ytrain)) * 100);
fprintf('Validation Set Accuracy:  %f\n', mean(double(pVal == yval)) * 100);
fprintf('Test Set Accuracy:        %f\n', mean(double(pTest == ytest)) * 100);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Write a detailed predictions for each audio clip in the data set
% The columns of the CSV file include
% > The prediction:   1 or 2 (integer)
% > The probability of class 1 (floating point number)
% > The probability of class 2 (floating point number)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

printf("  trainingSetPrecitions = %s\n", trainingSetPredictionsCsvFile);
csvwrite(trainingSetPredictionsCsvFile, [pTrain pTrainProb1 pTrainProb2]);

printf("validationSetPrecitions = %s\n", validationSetPredictionsCsvFile);
csvwrite(validationSetPredictionsCsvFile, [pVal pValProb1 pValProb2]);

printf("      testSetPrecitions = %s\n", testSetPredictionsCsvFile);
csvwrite(testSetPredictionsCsvFile, [pTest pTestProb1 pTestProb2]);


