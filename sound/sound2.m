
%  Instructions
%  ------------
% 
%  This file contains code that helps you get started on the
%  linear exercise. You will need to complete the following functions 
%  in this exericse:
%
%     lrCostFunction.m (logistic regression cost function)
%     oneVsAll.m
%     predictOneVsAll.m
%     predict.m
%
%  For this exercise, you will not need to change any code in this file,
%  or any other files other than those mentioned above.
%

%% Initialization
clear ; close all; clc

%% Setup the parameters you will use for this part of the exercise
input_layer_size  = 1000;  % 20x20 Input Images of Digits
num_labels = 2;          % 10 labels, from 1 to 10   
                          % (note that we have mapped "0" to label 10)

%% =========== Part 1: Loading and Visualizing Data =============
%  We start the exercise by first loading and visualizing the dataset. 
%  You will be working with a dataset that contains handwritten digits.
%

% Load Training Data
fprintf('Loading and Visualizing Data ...\n')

% training data stored in arrays X, y
%[X y] = prepareTrainingData();
load('train2.mat');

m = size(X, 1);

fprintf('Program paused. Press enter to continue.\n');
pause;



%% ============ Compute Cost and Gradient ============
%  In this part of the exercise, you will implement the cost and gradient
%  for logistic regression. You neeed to complete the code in
%  costFunction.m

%  Setup the data matrix appropriately, and add ones for the intercept term
[m, n] = size(X);

% Add intercept term to x and X_test
X = [ones(m, 1) X];

% Initialize fitting parameters
initial_theta = zeros(n + 1, 1);

% Compute and display initial cost and gradient
[cost, grad] = costFunction(initial_theta, X, y);

fprintf('Cost at initial theta (zeros): %f\n', cost);
%fprintf('Gradient at initial theta (zeros): \n');
%fprintf(' %f \n', grad);

fprintf('\nProgram paused. Press enter to continue.\n');
pause;




%% ============= Optimizing using fminunc  =============
%  In this exercise, you will use a built-in function (fminunc) to find the
%  optimal parameters theta.

%  Set options for fminunc
options = optimset('GradObj', 'on', 'MaxIter', 400);

%  Run fminunc to obtain the optimal theta
%  This function will return theta and the cost
[theta, cost] = ...
        fminunc(@(t)(costFunction(t, X, y)), initial_theta, options);

% Print theta to screen
fprintf('Cost at theta found by fminunc: %f\n', cost);
%fprintf('theta: \n');
%fprintf(' %f \n', theta);



%% ================ Predictions  ================

% Compute accuracy on our training set
p = predict(theta, X);

fprintf('Train Accuracy: %f\n', mean(double(p == y)) * 100);

%sigmoid(X(1,:)) * theta;
for i = 1:m
  fprintf('predict: song %d is %d, sigmoid is %f\n', i, p(i), sigmoid(X(i,:))*theta);  
endfor


fprintf('\nProgram paused. Press enter to continue.\n');
pause;


%% ================ Predictions  ================



fprintf('Train Accuracy: %f\n', mean(double(p == y)) * 100);

%% =========== Loading Test Data =============

fprintf('Loading Test Data ...\n')

% test data stored in matrix T
%T = prepareTestData();





%%%load('test2.mat');

%  Setup the data matrix appropriately, and add ones for the intercept term
%%%[m, n] = size(T);

% Add intercept term to x and X_test
%%%T = [ones(m, 1) T];



fprintf('Program paused. Press enter to continue.\n');
pause;

%%%p = predict(theta, T);

%%%for i = 1:m
%%%  fprintf('predict: song %d is %d, sigmoid is %f\n', i, p(i), sigmoid(T(i,:))*theta);  
%%%endfor






