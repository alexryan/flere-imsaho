%

%% Initialization
clear ; close all; clc

%% Define the architecture of the neural net
input_layer_size  = 4000;  % 20x20 Input Images of Digits
hidden_layer_size = 10;    % 25 hidden units
num_labels = 2;            % 2 labels: {1,2}   
                          % (note that we have mapped "0" to label 10)

fprintf('Loading data. This could take a while. Chill! Patience is a virtue!\n');

fprintf('\nLoading da training data ...\n')
% training data stored in arrays X, y 
load('/Users/alexryan/alpine/git/flere-imsaho/data/matlab/experiment-training.mat');
fprintf(" dimensions of X: %d x %d\n", size(X,1), size(X,2));
fprintf(" dimensions of y: %d x %d\n", size(y,1), size(y,2));

fprintf('\nLoading da test data ...\n')
% test data stored in arrays A, b (change to Xtest, ytest)
load('/Users/alexryan/alpine/git/flere-imsaho/data/matlab/experiment-test.mat');
m = size(A, 1);
fprintf(" dimensions of Xtest: %d x %d\n", size(A,1), size(A,2));
fprintf(" dimensions of ytest: %d x %d\n", size(b,1), size(b,2));

% Load the neural network parameters that were trained in trainNN.m
% variables Theta1 and Theta2 should now contain the weights
fprintf('\nLoading da magical Neural Network Parameters ...\n')
load('/Users/alexryan/alpine/git/flere-imsaho/data/matlab/experiment-weights.mat');
fprintf(" dimensions of Theta1: %d x %d\n", size(Theta1,1), size(Theta1,2));
fprintf(" dimensions of Theta2: %d x %d\n", size(Theta2,1), size(Theta2,2));


fprintf("\nand the drum roll ... what will the results be?");
pause;

pred = predict(Theta1, Theta2, X);
fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);

pred = predict(Theta1, Theta2, A);
fprintf('Test Set Accuracy: %f\n', mean(double(pred == b)) * 100);

