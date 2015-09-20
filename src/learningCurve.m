function [mvec, error_train, error_val] = ...
    learningCurve(X, y, Xval, yval, lambda)
%LEARNINGCURVE Generates the train and cross validation set errors needed 
%to plot a learning curve
%   [error_train, error_val] = ...
%       LEARNINGCURVE(X, y, Xval, yval, lambda) returns the train and
%       cross validation set errors for a learning curve. In particular, 
%       it returns two vectors of the same length - error_train and 
%       error_val. Then, error_train(i) contains the training error for
%       i examples (and similarly for error_val(i)).

% How many samples do we want to take to plot our curves?
m = 10;

% Let mvec be a vector of size m
% containing increasing sample sizes to be taken from the training set
% to train each of m models
min = 0;
max = size(Xval, 1);
interval = (max-min)/m;
mvec = 1:interval:max;

fprintf("size(Xval,1) = %d\n", size(Xval,1));
fprintf("mvec (sample sizes used to generate each error value on the plot)\n");
disp(mvec');

% You need to return these values correctly
error_train = zeros(m, 1);
error_val   = zeros(m, 1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Configure the neural net
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% We're ONLY loading the weights here so that we can get the current
% dimensions of the matrices.
load('/Users/alexryan/alpine/git/flere-imsaho/data/matlab/flere-imsaho-weights.mat');

%input_layer_size  = 500;  % audio data
%hidden_layer_size = 5;    % hidden units
%num_labels = 2;           % 2 labels: {1,2}   

input_layer_size  = size(Theta1,2) - 1;
hidden_layer_size = size(Theta2,2) - 1;
num_labels        = size(Theta2,1);

%fprintf('\nRandomly initializing the weights of the neural net...');
Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
initial_nn_params = [Theta1(:) ; Theta2(:)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute train/cross validation errors using training examples 
% X(1:i, :) and y(1:i), storing the result in 
% error_train(i) and error_val(i)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

i = 1;
for mvecIndex=1:length(mvec)
  m = mvec(mvecIndex);
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Fit the parameters theta with the training set
  % The training set will have i examples.
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  options = optimset('MaxIter', 10);
  % Create "short hand" for the cost function to be minimized
  costFunction = @(p) nnCostFunction(p, ...
                                     input_layer_size, ...
                                     hidden_layer_size, ...
                                     num_labels, X(1:m,:), y(1:m), lambda);

  % Now, costFunction is a function that takes in only one argument (the
  % neural network parameters)
  tic;
  [nn_params, cost] = fmincg(costFunction, initial_nn_params, options);
  timeElapsed = toc;
  printf("\nTime to train: %d seconds\n", timeElapsed);
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Calculate the error on the training set
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  error_train(i) = nnCostFunction(nn_params, input_layer_size, ...
                                  hidden_layer_size, num_labels, X(1:m,:), y(1:m), 0);
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\
  % Calculate the error on the cross validation set
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  error_val(i) = nnCostFunction(nn_params, input_layer_size, ...
                                hidden_layer_size, num_labels, Xval, yval, 0);

  i = i+1;
end

end
