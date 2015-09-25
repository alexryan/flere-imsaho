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

%trainingSetCsvFile   = [getenv("FLERE_IMSAHO") "/data/matlab/training-set.csv"];
%validationSetCsvFile = [getenv("FLERE_IMSAHO") "/data/matlab/validation-set.csv"];
testSetCsvFile       = [getenv("FLERE_IMSAHO") "/data/matlab/test-set.csv"];

%matlabTrainingFile   = fullfile(getenv("FLERE_IMSAHO"), "data/matlab", "flere-imsaho-train.mat");
%matlabValidationFile = fullfile(getenv("FLERE_IMSAHO"), "data/matlab", "flere-imsaho-val.mat");
matlabTestFile       = fullfile(getenv("FLERE_IMSAHO"), "data/matlab", "flere-imsaho-test.mat");

% WRITING ...
%trainingSetPredictionsCsvFile    = [getenv("FLERE_IMSAHO") "/data/matlab/training-set-predictions.csv"];
%validationSetPredictionsCsvFile  = [getenv("FLERE_IMSAHO") "/data/matlab/validation-set-predictions.csv"];
testSetPredictionsCsvFile        = [getenv("FLERE_IMSAHO") "/data/matlab/test-set-predictions.csv"];


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

%pred1 = predict(Theta1, Theta2, Xtrain);
%pred2 = predict(Theta1, Theta2, Xval);

%predictions = zeros(size(Xtest,1));
[pred3 p1 p2 ] = predict(Theta1, Theta2, Xtest);

%fprintf('Training Set Accuracy:    %f\n', mean(double(pred1 == ytrain)) * 100);
%fprintf('Validation Set Accuracy:  %f\n', mean(double(pred2 == yval)) * 100);
fprintf('Test Set Accuracy:        %f\n', mean(double(pred3 == ytest)) * 100);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Write a detailed predictions for each audio clip in the data set
% The columns of the CSV file include
% > The prediction:   1 or 2 (integer)
% > The probability of class 1 (floating point number)
% > The probability of class 2 (floating point number)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

printf("testSetPrecitions  = %s\n", testSetPredictionsCsvFile);
csvwrite(testSetPredictionsCsvFile, [pred3 p1 p2]);


