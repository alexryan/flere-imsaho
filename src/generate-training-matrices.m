%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% generate-training-matrices.m
%
% Pre-requisites:
%   (1) csv containing list of audio files o be processed and their labels
%   exists here:
%     $ALPINE_GIT/machineLearn/data/audio/experiment.csv
%   (2) actual audio files exist here:
%     $ALPINE_GIT/machineLearn/data/audio/snippets
%
% Usage:
%
% octave generate-training-matrices.m
% ls -lF train2.mat
% octave
% >> load('train2.mat');
% >> size(X)
% >> size(y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialization
clear ; close all; clc

cdCommand = ["cd " getenv("ALPINE_GIT") "/machineLearning/data/audio"]
disp(cdCommand)
system(cdCommand)

csvFile = [getenv("ALPINE_GIT") "/machineLearning/data/audio/experiment.csv"]
disp(csvFile)

path2RawSongFiles =  [getenv("ALPINE_GIT") "/machineLearning/data/audio/snippets"]

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
% 0 = low intensity
% 1 = high intensity
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%y = [0; 0; 0; 0; 0; 1; 1; 1; 1; 1];

%cd ..
%save 'train2.mat' X y

