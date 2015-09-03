%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot the learning curves
% (1) "training error" versus "number of exmples"
% (2) "cross validation error" versus "number of examples"
% Question: who is our enemy today?
% bias or variance?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialization
clear ; close all; clc

% Load data: 
% You will have Xtrain, ytrain, Xval, yval in your environment

fprintf('\nLoading da training data ...\n')
% training data stored in arrays Xtrain, ytrain 
load('/Users/alexryan/alpine/git/flere-imsaho/data/matlab/flere-imsaho-train.mat');
fprintf(" dimensions of X: %d x %d\n", size(Xtrain,1), size(Xtrain,2));
fprintf(" dimensions of y: %d x %d\n", size(ytrain,1), size(ytrain,2));

fprintf('\nLoading da test data ...\n')
% test data stored in arrays Xval, yval
load('/Users/alexryan/alpine/git/flere-imsaho/data/matlab/flere-imsaho-val.mat');
fprintf(" dimensions of Xtest: %d x %d\n", size(Xval,1), size(Xval,2));
fprintf(" dimensions of ytest: %d x %d\n", size(yval,1), size(yval,2));

lambda = 3;

[error_train, error_val] = ...
    learningCurve([Xtrain], ytrain, ...
                  [Xval], yval, ...
                  lambda);

m = size(Xval,1);

plot(1:m, error_train, 1:m, error_val);
title('Learning curve')
legend('Train', 'Cross Validation')
xlabel('Number of training examples')
ylabel('Error')
axis([0 80 0 5])

fprintf('# Training Examples\tTrain Error\tCross Validation Error\n');
for i = 1:m
    fprintf('  \t%d\t\t%f\t%f\n', i, error_train(i), error_val(i));
end



