%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% generate-training-matrices.m
%
% Pre-requisites:
%   (1) csv containing list of audio files o be processed and their labels
%   exists here:
%     $ALPINE_GIT/machineLearn/data/audio/experiment.labels.csv
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

csvFile = [getenv("ALPINE_GIT") "/machineLearning/data/audio/experiment.labels.csv"]
disp(csvFile)

path2RawSongFiles =  [getenv("ALPINE_GIT") "/machineLearning/data/audio/full"]

[songs, y] = textread(csvFile, "%s %f", "delimiter", ",");

%disp(songs)
%disp(y)

for i = 1:length(songs)
  printf("song=|%s|\n", songs{i,1});
  raw = [songs{i,1} "mono-sr41000-ss16"]
  printf("raw=|%s|\n", raw);
  raw = [path2RawSongFiles "/" raw]
  raw = [songs{i,1} "mono-sr41000-ss16"]

  %songVector = loadaudio(songVector, 'raw', 16);
  %X(i,:) = song1(1:1000,1);
end

%song1 = loadaudio('001-A_Thousand_Years.mono-sr41000-ss16', 'raw', 16);
%X(1,:) = song1(40001:41000,1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0 = low intensity
% 1 = high intensity
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%y = [0; 0; 0; 0; 0; 1; 1; 1; 1; 1];

%cd ..
%save 'train2.mat' X y

