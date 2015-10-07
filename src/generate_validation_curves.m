%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot the validation curves
% (1) "training error" versus "lambda"
% (2) "cross validation error" versus "lambda"
% Question: what is the best value of lambda?
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

tic;
fprintf(" dimensions of Xtrain: %d x %d\n", size(Xtrain,1), size(Xtrain,2))
fprintf(" dimensions of ytrain: %d x %d\n", size(ytrain,1), size(ytrain,2))

fprintf(" dimensions of Xval:   %d x %d\n", size(Xval,1), size(Xval,2))
fprintf(" dimensions of yval:   %d x %d\n", size(yval,1), size(yval,2))

time1=toc;
fprintf("time1=: %d\n", time1)

[lambda_vec, error_train, error_val] = ...
validationCurve(Xtrain, ytrain, Xval, yval);


plot(lambda_vec, error_train, lambda_vec, error_val);
legend('Train', 'Cross Validation');
xlabel('lambda');
ylabel('Error');

fprintf('lambda\t\tTrain Error\tValidation Error\n');
for i = 1:length(lambda_vec)
  fprintf(' %f\t%f\t%f\n', ...
	  lambda_vec(i), error_train(i), error_val(i));
end

