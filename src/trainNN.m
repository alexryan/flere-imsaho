% train the neural net

%% Initialization
clear ; close all; clc

%% Setup the parameters you will use for this exercise
input_layer_size  = 4000;  % 20x20 Input Images of Digits
hidden_layer_size = 10;    % 25 hidden units
num_labels = 2;            % 2 labels: {1,2}   

fprintf('Loading da training data ...\n');
% training data stored in arrays X, y
load('/Users/alexryan/alpine/git/flere-imsaho/data/matlab/experiment-training.mat');
m = size(X, 1);

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
lambda = 3;

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X, y, lambda);

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

matlabWeightsFile = fullfile(getenv("FLERE_IMSAHO"), "data/matlab", "experiment-weights.mat");
save(matlabWeightsFile, 'Theta1', 'Theta2');
fprintf("da magical learned parameters have been saved here:\n%s\n", matlabWeightsFile);

