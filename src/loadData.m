%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem:
%   Loading data is a really slow operation.
%   But most things we want to do require this data to be loaded.
% Solution:
%   Load the data once into global variables in the workspace.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%disp('Contents of workspace:')
%whos

%disp('Contents of flere-imsaho-train.mat:')
%whos('-file','/Users/alexryan/alpine/git/flere-imsaho/data/matlab/flere-imsaho-train.mat')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load the training data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tic;
fprintf('\nLoading da training data ...\n')
% training data stored in matrix Xtrain and vector ytrain
s = load('/Users/alexryan/alpine/git/flere-imsaho/data/matlab/flere-imsaho-train.mat');
time1 = toc;
fprintf("time to load the training data=: %d\n", time1)

n = fieldnames(s);
for k=1:length(n)
  eval(sprintf('global %s; %s=s.%s;',n{k},n{k},n{k}));
end
clear s;

%disp('Contents of workspace:')
%whos


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load the cross validation data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tic;
fprintf('\nLoading da cross validation data ...\n')
% cross validation data stored in matrix Xval and vector yval
s = load('/Users/alexryan/alpine/git/flere-imsaho/data/matlab/flere-imsaho-val.mat');
time2 = toc;
fprintf("time to load validation data=: %d\n", time2)

n = fieldnames(s);
for k=1:length(n)
  eval(sprintf('global %s; %s=s.%s;',n{k},n{k},n{k}));
end
clear s;

%disp('Contents of workspace:')
%whos


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load the test data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tic;
fprintf('\nLoading da test data ...\n')
% test data stored in matrix Xtest and vector ytest
s = load('/Users/alexryan/alpine/git/flere-imsaho/data/matlab/flere-imsaho-test.mat');
time3 = toc;
fprintf("time to load the test data=: %d\n", time3)

n = fieldnames(s);
for k=1:length(n)
  eval(sprintf('global %s; %s=s.%s;',n{k},n{k},n{k}));
end
clear s;

disp('Contents of workspace:')
whos('global')


