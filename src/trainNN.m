% train the neural net

%% Initialization
close all; clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NOTE
% This script requires that the data has already been loaded into global variables
% for processing.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global Xtrain;
global ytrain;


fprintf(" dimensions of Xtrain: %d x %d\n", size(Xtrain,1), size(Xtrain,2));
fprintf(" dimensions of ytrain: %d x %d\n", size(ytrain,1), size(ytrain,2));

%fprintf('Loading da training data ...\n');
%% training data stored in arrays Xtrain, ytrain
%load('/Users/alexryan/alpine/git/flere-imsaho/data/matlab/flere-imsaho-train.mat');
m = size(Xtrain, 1);

%% Setup the parameters you will use for this exercise
input_layer_size  = 1000;  % 1 sec clip from song; sampling rate = 1000Hz
hidden_layer_size = 5;     % 5 hidden units
num_labels = 2;            % 2 labels: {1,2}   


%fprintf('\nRandomly initializing the weights of the neural net...');
Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters 
nn_params = [Theta1(:) ; Theta2(:)];

%fprintf('\nFeedforward Using Neural Network ...\n');

% Weight regularization parameter (we set this to 0 here).
%lambda = 0;
%J = nnCostFunction(nn_params, input_layer_size, hidden_layer_size, ...
%                   num_labels, X, y, lambda);
%fprintf(['lambda=0; Cost at parameters (randomly initialized): %f\n'], J);


% Weight regularization parameter (we set this to 1 here).
%lambda = 1;
%J = nnCostFunction(nn_params, input_layer_size, hidden_layer_size, ...
%                   num_labels, X, y, lambda);
%fprintf(['lambda=1; Cost at parameters (randomly initialized): %f\n'], J);


%fprintf('\nInitializing Neural Network Parameters ...\n')
initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];


% Turn off gradient checking when it is verified that backprop is working correctly

% Check gradients by running checkNNGradients
%fprintf('\nChecking Backpropagation... \n');
%checkNNGradients;

%  Check gradients by running checkNNGradients
%fprintf('\nChecking Backpropagation (w/ Regularization) ... \n')
%lambda = 3;
%checkNNGradients(lambda);


% Also output the costFunction debugging values
%lambda = 3;
%debug_J  = nnCostFunction(nn_params, input_layer_size, ...
%                          hidden_layer_size, num_labels, X, y, lambda);
%fprintf(['lambda=3; Cost at parameters (randomly initialized): %f\n'], debug_J);


%fprintf('Program paused. Press enter to start training ...\n');
%pause;


% Train the Neural Net
fprintf('\nTraining the neural net ... \n');

%options = optimset('MaxIter', 20);
options = optimset('MaxIter', 50);
%options = optimset('MaxIter', 200);

%lambda = 1;
%lambda = 3;
%lambda = 640000;
%lambda = 300;
%lambda = 0;
%lambda = 250;
lambda = 0;

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, Xtrain, ytrain, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);


% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

%fprintf('Program paused. New weights learned. Press enter to save them to a file...\n');
%pause;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Persist the weights to a matlab data file.
% Example:
%   save '/Users/alexryan/alpine/git/flere-imhaso/data/matlab/experiment-weights.mat' Theta1 Theta2
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

matlabWeightsFile = fullfile(getenv("FLERE_IMSAHO"), "data/matlab", "flere-imsaho-weights.mat");
save(matlabWeightsFile, 'Theta1', 'Theta2');
fprintf("da magical learned parameters have been saved here:\n%s\n", matlabWeightsFile);

