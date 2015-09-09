%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem:
%   Loading data is a really slow operation.
%   But most things we want to do require this data to be loaded.
% Solution:
%   Load the data once into global variables in the workspace.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Contents of workspace:')
whos

disp('Contents of flere-imsaho-train.mat:')
whos('-file','/Users/alexryan/alpine/git/flere-imsaho/data/matlab/flere-imsaho-train.mat')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load the training data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('\nLoading da training data ...\n')
% training data stored in matrix Xtrain and vector ytrain
s = load('/Users/alexryan/alpine/git/flere-imsaho/data/matlab/flere-imsaho-train.mat');
%fprintf(" dimensions of X: %d x %d\n", size(Xtrain,1), size(Xtrain,2));
%fprintf(" dimensions of y: %d x %d\n", size(ytrain,1), size(ytrain,2));

n = fieldnames(s);
for k=1:length(n)
  eval(sprintf('global %s; %s=s.%s;',n{k},n{k},n{k}));
end
clear s;

disp('Contents of workspace:')
whos


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load the cross validation data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('\nLoading da cross validation data ...\n')
% cross validation data stored in matrix Xval and vector yval
s = load('/Users/alexryan/alpine/git/flere-imsaho/data/matlab/flere-imsaho-val.mat');
%fprintf(" dimensions of Xval: %d x %d\n", size(Xval,1), size(Xval,2));
%fprintf(" dimensions of yval: %d x %d\n", size(yval,1), size(yval,2));

n = fieldnames(s);
for k=1:length(n)
  eval(sprintf('global %s; %s=s.%s;',n{k},n{k},n{k}));
end
clear s;

disp('Contents of workspace:')
whos


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load the test data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('\nLoading da test data ...\n')
% test data stored in matrix Xtest and vector ytest
s = load('/Users/alexryan/alpine/git/flere-imsaho/data/matlab/flere-imsaho-test.mat');
%fprintf(" dimensions of Xtest: %d x %d\n", size(Xtest,1), size(Xtest,2));
%fprintf(" dimensions of ytest: %d x %d\n", size(ytest,1), size(ytest,2));

n = fieldnames(s);
for k=1:length(n)
  eval(sprintf('global %s; %s=s.%s;',n{k},n{k},n{k}));
end
clear s;

disp('Contents of workspace:')
whos


% Load the neural network parameters that were trained in trainNN.m
% variables Theta1 and Theta2 should now contain the weights
%fprintf('\nLoading da magical Neural Network Parameters ...\n')
%load('/Users/alexryan/alpine/git/flere-imsaho/data/matlab/flere-imsaho-weights.mat');
%fprintf(" dimensions of Theta1: %d x %d\n", size(Theta1,1), size(Theta1,2));
%fprintf(" dimensions of Theta2: %d x %d\n", size(Theta2,1), size(Theta2,2));


