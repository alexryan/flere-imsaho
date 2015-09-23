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
% NOTE
% This script requires that the data has already been loaded into global variables
% for processing.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global Xtrain;
global ytrain;
global Xval;
global yval;
global Xtest;
global ytest;

fprintf(" dimensions of X: %d x %d\n", size(Xtrain,1), size(Xtrain,2));
fprintf(" dimensions of y: %d x %d\n", size(ytrain,1), size(ytrain,2));

fprintf(" dimensions of Xval: %d x %d\n", size(Xval,1), size(Xval,2));
fprintf(" dimensions of yval: %d x %d\n", size(yval,1), size(yval,2));

fprintf(" dimensions of Xtest: %d x %d\n", size(Xtest,1), size(Xtest,2));
fprintf(" dimensions of ytest: %d x %d\n", size(ytest,1), size(ytest,2));

% Load the neural network parameters that were trained in trainNN.m
% variables Theta1 and Theta2 should now contain the weights
fprintf('\nLoading da magical Neural Network Parameters ...\n')
load('/Users/alexryan/alpine/git/flere-imsaho/data/matlab/flere-imsaho-weights.mat');
fprintf(" dimensions of Theta1: %d x %d\n", size(Theta1,1), size(Theta1,2));
fprintf(" dimensions of Theta2: %d x %d\n", size(Theta2,1), size(Theta2,2));


fprintf("\nand the drum roll ... what will the results be?\n");
pause;


pred1 = predict(Theta1, Theta2, Xtrain);
pred2 = predict(Theta1, Theta2, Xval);
pred3 = predict(Theta1, Theta2, Xtest);

fprintf('Training Set Accuracy:    %f\n', mean(double(pred1 == ytrain)) * 100);
fprintf('Validation Set Accuracy:  %f\n', mean(double(pred2 == yval)) * 100);
fprintf('Test Set Accuracy:        %f\n', mean(double(pred3 == ytest)) * 100);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The OMTM (one metric that matters)
% is "cross valiation error"
% If this goes DOWN, we celebrate.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Unroll parameters
nn_params         = [Theta1(:) ; Theta2(:)];
%input_layer_size  = 500;   % audio data
%hidden_layer_size = 5;     % hidden units
%num_labels        = 2;     % 2 labels: {1,2}

input_layer_size  = size(Theta1,2) - 1;
hidden_layer_size = size(Theta2,2) - 1;
num_labels        = size(Theta2,1);

training_error    = nnCostFunction(nn_params, input_layer_size, ...
                                   hidden_layer_size, num_labels, Xtrain, ytrain, 0);
validation_error  = nnCostFunction(nn_params, input_layer_size, ...
                                   hidden_layer_size, num_labels, Xval, yval, 0);
test_error        = nnCostFunction(nn_params, input_layer_size, ...
                                   hidden_layer_size, num_labels, Xtest, ytest, 0);

fprintf('Training Set Error:       %f\n', training_error);
fprintf('Validation Set Error:     %f\n', validation_error);
fprintf('Test Set Error:           %f\n', test_error);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute precision, recall and the f-number
% These are important metrics when the data set is skewed.
% i.e. when we do not have a similar number of examples for each class.
%
% Precision measures our ratio of "true positives" to "predicted positives".
% Higher precision means fewer "false positives".
%
% Recall measures our ratio of "true positives" to "actual positives".
% Higher recall means fewer "false negatives"
%
% We WANT
% High Precision and High Recall
% F-Score is the metric which measures our ability to get both
% The Higher the F-Score the better.
% The F-Score varies between 0 and 1.
% We want a value as close to 1 as possible.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

positiveLabel   = 2;
true_positives  = countTruePositives(pred3, ytest, positiveLabel);
true_negatives  = countTrueNegatives(pred3, ytest, positiveLabel);
false_positives = countFalsePositives(pred3, ytest, positiveLabel);
false_negatives = countFalseNegatives(pred3, ytest, positiveLabel);

% precision = true_positives / predicted_positives;
precision = true_positives / (true_positives + false_positives);

% recall = true_positives / actual_positives;
recall    = true_positives / (true_positives + false_negatives);

fscore    = 2 * (precision * recall) / (precision + recall);

fprintf('Number of Predictions:    %d\n', size(pred3,1));
fprintf('True Positives:           %d\n', true_positives);
fprintf('True Negatives:           %d\n', true_negatives);
fprintf('False Positives:          %d\n', false_positives);
fprintf('False Negatives:          %d\n', false_negatives);

fprintf('Precision:                %f\n', precision);
fprintf('Recall:                   %f\n', recall);
fprintf('F-Score:                  %f\n', fscore);
