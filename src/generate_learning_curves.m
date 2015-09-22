%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot the learning curves
% (1) "training error" versus "number of exmples"
% (2) "cross validation error" versus "number of examples"
% Question: who is our enemy today?
% bias or variance?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialization
%clear;
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

%fprintf('\nLoading da training data ...\n')
%% training data stored in arrays Xtrain, ytrain 
%load('/Users/alexryan/alpine/git/flere-imsaho/data/matlab/flere-imsaho-train.mat');
fprintf(" dimensions of X: %d x %d\n", size(Xtrain,1), size(Xtrain,2));
fprintf(" dimensions of y: %d x %d\n", size(ytrain,1), size(ytrain,2));

%fprintf('\nLoading da test data ...\n')
%% test data stored in arrays Xval, yval
%load('/Users/alexryan/alpine/git/flere-imsaho/data/matlab/flere-imsaho-val.mat');
fprintf(" dimensions of Xval: %d x %d\n", size(Xval,1), size(Xval,2));
fprintf(" dimensions of yval: %d x %d\n", size(yval,1), size(yval,2));

lambda = 0;

[mvec, error_train, error_val] = ...
    learningCurve([Xtrain], ytrain, ...
                  [Xval], yval, ...
                  lambda);

m = size(error_train);

plot(mvec, error_train, mvec, error_val);
title('Learning curve')
legend('Train', 'Cross Validation')
xlabel('Number of training examples')
ylabel('Error')
maxX = mvec(size(mvec,2));
maxY = max(error_val);
axis([0 maxX 0 maxY])

fprintf('# Training Examples\tTrain Error\tCross Validation Error\n');
for i = 1:m
    fprintf('  \t%d\t\t%f\t%f\n', i, error_train(i), error_val(i));
end

