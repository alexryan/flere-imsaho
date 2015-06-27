%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% generate-training-matrices.m
%
% Process a bunch of audio files and generate 2 matrices for machine learning
% in an Matlab file.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Usage:
%
% octave generate-training-matrices.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% What you get ...
%
% After running this script, a Matlab file will magically appear here:
%   $ALPINE_GIT/machineLearning/data/matlab/experiment-train.mat' 
%
% It will contain 2 matrices: X & y
% X is an 1000xm matrix, where m = the number of songs.
% X contains a sample of the song wave.
% y is an mx1 vector which contains a label for each of the songs in the training set.
% Currently, there are 2 labels: 0 and 1
% 0 = low intensity
% 1 = high intensity
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pre-requisites:
%
%   (1) csv containing list of audio files o be processed and their labels exists here:
%     $ALPINE_GIT/machineLearn/data/audio/experiment.csv
%   (2) actual audio files exist here:
%     $ALPINE_GIT/machineLearn/data/audio/snippets
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Did it work???
% Here's how to find out ...
%
$ cd $ALPINE_GIT/machineLearning/data/matlab
% ls -lF experiment-train.mat
% octave
% >> load('experiment-train.mat');
% >> size(X)
% >> size(y)
% >> plot(X(24,400:600))
%
% If you see stuff, it probably worked.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialization
clear ; close all; clc

%cdCommand = ["cd " getenv("ALPINE_GIT") "/machineLearning/data/audio"]
%disp(cdCommand)
%system(cdCommand)

csvFile = [getenv("ALPINE_GIT") "/machineLearning/data/audio/experiment.csv"]
disp(csvFile)

%matlabFile = [getenv("ALPINE_GIT") "/machineLearning/data/matlab/experiment-train.mat"]
%disp(matlabFile)

path2RawSongFiles = [getenv("ALPINE_GIT") "/machineLearning/data/audio/snippets"]
[songs, y] = textread(csvFile, "%s %f", "delimiter", ",");

%disp(songs)
%disp(y)

for i = 1:length(songs)
  printf("song=|%s|\n", songs{i,1});

  raw = [songs{i,1} ".mono-sr4000-ss16"]
  printf("raw=|%s|\n", raw);

  raw = [path2RawSongFiles "/" raw]
  printf("raw=|%s|\n", raw);

  songVector = loadaudio(raw, 'raw', 16);
  X(i,:) = songVector(1:1000,1);
end

printf("SIZE:\n")
disp(size(X))


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% y: label vector
% 0 = low intensity
% 1 = high intensity
% Save the data to a matlab file.
% Example:
%   save '/Users/alexryan/alpine/git/machineLearning/data/matlab/output1.mat' X y
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This works:

matlabFile = fullfile(getenv("ALPINE_GIT"), "machineLearning/data/matlab", "output2.mat")
disp(matlabFile)
save(matlabFile, 'X', 'y')


