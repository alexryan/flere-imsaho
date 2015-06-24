%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% predict the intensity of music tracks
% 0 = low intensity
% 1 = high intensity
%
% load the training data
% build the classifier
% make predictions against the training data
% make predictions against test data
%
% train2.mat: the training data
% test2.mat:  the test data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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

fprintf('Loading da training data ...\n')
% training data stored in arrays X, y
load('train2.mat');

fprintf('Program paused. Press enter to continue.\n');
pause;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Compute the cost and gradient for logistic regression. 
%  costFunction.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Optimize using fmiunc
% Unse fminunc to find the optimal parameters theta.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Make Predicitons
% using the training data
% i.e. If this doesn't work, something is REALLY broken
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Compute accuracy on our training set
p = predict(theta, X);

fprintf('Train Accuracy: %f\n', mean(double(p == y)) * 100);

%sigmoid(X(1,:)) * theta;
for i = 1:m
  fprintf('predict: song %d is %d, sigmoid is %f\n', i, p(i), sigmoid(X(i,:))*theta);  
endfor

fprintf('\nProgram paused. Press enter to continue.\n');
pause;

fprintf('Train Accuracy: %f\n', mean(double(p == y)) * 100);
pause;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Make Predicitons
% using the test data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('Loading Test Data ...\n')

% test data stored in matrix A and vector b
load('test3.mat');

%  Setup the data matrix appropriately, and add ones for the intercept term
[m, n] = size(A);

% Add intercept term to x and X_test
A = [ones(m, 1) A];

fprintf('Program paused. Press enter to continue.\n');
pause;

p = predict(theta, A);

for i = 1:m
  fprintf('predict: song %d is %d, actual is %d, sigmoid is %f\n', i, p(i), b(i), sigmoid(A(i,:))*theta);  
endfor

fprintf('Test Accuracy: %f\n', mean(double(p == b)) * 100);


