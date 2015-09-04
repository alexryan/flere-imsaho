%

%% Initialization
clear ; close all; clc

%% Define the architecture of the neural net
input_layer_size  = 4000;  % 20x20 Input Images of Digits
hidden_layer_size = 10;    % 25 hidden units
num_labels = 2;            % 2 labels: {1,2}   
                          % (note that we have mapped "0" to label 10)

printf('Loading data. This could take a while. Chill! Patience is a virtue!\n');

fprintf('\nLoading da training data ...\n')
% training data stored in matrix Xtrain and vector ytrain
load('/Users/alexryan/alpine/git/flere-imsaho/data/matlab/flere-imsaho-train.mat');
fprintf(" dimensions of X: %d x %d\n", size(Xtrain,1), size(Xtrain,2));
fprintf(" dimensions of y: %d x %d\n", size(ytrain,1), size(ytrain,2));

fprintf('\nLoading da cross validation data ...\n')
% cross validation data stored in matrix Xval and vector yval
load('/Users/alexryan/alpine/git/flere-imsaho/data/matlab/flere-imsaho-val.mat');
fprintf(" dimensions of Xtest: %d x %d\n", size(Xval,1), size(Xval,2));
fprintf(" dimensions of ytest: %d x %d\n", size(yval,1), size(yval,2));

fprintf('\nLoading da test data ...\n')
% test data stored in matrix Xtest and vector ytest
load('/Users/alexryan/alpine/git/flere-imsaho/data/matlab/flere-imsaho-test.mat');
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
fprintf('Validation  Set Accuracy: %f\n', mean(double(pred2 == yval)) * 100);
fprintf('Test Set Accuracy:        %f\n', mean(double(pred3 == ytest)) * 100);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The OMTM (one metric that matters)
% The "single real value evaluation metric"
% is "cross valiation error"
% If this goes DOWN, we celebrate.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Unroll parameters
nn_params         = [Theta1(:) ; Theta2(:)];
input_layer_size  = 4000;  % audio data
hidden_layer_size = 10;    % hidden units
num_labels        = 2;     % 2 labels: {1,2}

training_error    = nnCostFunction(nn_params, input_layer_size, ...
                                   hidden_layer_size, num_labels, Xtrain, ytrain, 0);
validation_error  = nnCostFunction(nn_params, input_layer_size, ...
                                   hidden_layer_size, num_labels, Xval, yval, 0);
test_error        = nnCostFunction(nn_params, input_layer_size, ...
                                   hidden_layer_size, num_labels, Xtest, ytest, 0);

fprintf('Training Set Error:       %f\n', training_error);
fprintf('Validation Set Error:     %f\n', validation_error);
fprintf('Test Set Error:           %f\n', test_error);
