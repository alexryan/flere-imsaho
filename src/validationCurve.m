function [lambda_vec, error_train, error_val] = ...
    validationCurve(X, y, Xval, yval)
%VALIDATIONCURVE Generate the train and validation errors needed to
%plot a validation curve that we can use to select lambda
%   [lambda_vec, error_train, error_val] = ...
%       VALIDATIONCURVE(X, y, Xval, yval) returns the train
%       and validation errors (in error_train, error_val)
%       for different values of lambda. You are given the training set (X,
%       y) and validation set (Xval, yval).
%

  % Selected values of lambda
  
  lambda_vec = [0 0.001 0.003 0.01 0.03 0.1 0.3 1 3 10];
  
  %min = 0;
  %max = 100;
  %interval = (max-min)/10;
  %lambda_vec = min:interval:max;
  
error_train = zeros(length(lambda_vec), 1);
error_val = zeros(length(lambda_vec), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return training errors in 
%               error_train and the validation errors in error_val. The 
%               vector lambda_vec contains the different lambda parameters 
%               to use for each calculation of the errors, i.e, 
%               error_train(i), and error_val(i) should give 
%               you the errors obtained after training with 
%               lambda = lambda_vec(i)
%
%

  % Compute train / val errors when training linear
  % regression with regularization parameter lambda
  % You should store the result in error_train(i)
  % and error_val(i)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Configure the neural net
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

input_layer_size  = 1000;  % audio data
hidden_layer_size = 5;    % hidden units
num_labels = 2;            % 2 labels: {1,2}   

tic;

% Randomly initialize the weights of the neural net
Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

vcTime1 = toc;
fprintf("vcTime1=: %d\n", vcTime1)

% Unroll parameters for fminuncg.
initial_nn_params = [Theta1(:) ; Theta2(:)];

% number of iterations for fminuncg?
options = optimset('MaxIter', 10);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Loop through the set of values for lambda.
% On each iteration.
%   Fit a model with the current value of lambda.
%   Use this model to compute
%   (1) training set error and
%   (2) validation set error.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:length(lambda_vec)
  lambda = lambda_vec(i);

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Fit the parameters theta with the training set
  % using a new value of lambda this time.
  % How awesome will *this* hypothesis be at diving the future?
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  % Create "short hand" for the cost function to be minimized
  costFunction = @(p) nnCostFunction(p, ...
                                     input_layer_size, ...
                                     hidden_layer_size, ...
                                     num_labels, X, y, lambda);

  % Now, costFunction is a function that takes in only one argument (the
  % neural network parameters)
  [nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Calculate the error on the training set
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  error_train(i) = nnCostFunction(nn_params, input_layer_size, ...
                                  hidden_layer_size, num_labels, X, y, 0);
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\
  % Calculate the error on the cross validation set
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  error_val(i) = nnCostFunction(nn_params, input_layer_size, ...
                                hidden_layer_size, num_labels, Xval, yval, 0);

end

end
