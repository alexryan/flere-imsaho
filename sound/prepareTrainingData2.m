%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% octave prepareTrainingData2.m
% ls -lF train2.mat
% octave
% >> load('train2.mat');
% >> size(X)
% >> size(y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialization
clear ; close all; clc
cd training_set2

song1 = loadaudio('001-A_Thousand_Years.mono-sr4000-ss8', 'raw', 8);
X(1,:) = song1(5001:6000,1);

song2 = loadaudio('002-The_Cello_Song-Bach_is_back.mono-sr4000-ss8', 'raw', 8);
X(2,:) = song2(5001:6000,1);


y = [0; 0; 0; 0; 0; 1; 1; 1; 1; 1];

cd ..
save 'train2.mat' X y

