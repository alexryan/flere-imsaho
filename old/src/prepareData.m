function [X y] = prepareData()


%% Initialization
clear ; close all; clc

load 'training_set/001-full'
X(1,:) = wavedata(1,[1:1000]);
load 'training_set/002-full'
X(2,:) = wavedata(1,[1:1000]);
load 'training_set/003-full'
X(3,:) = wavedata(1,[1:1000]);
load 'training_set/004-full'
X(4,:) = wavedata(1,[1:1000]);
load 'training_set/005-full'
X(5,:) = wavedata(1,[1:1000]);
load 'training_set/006-full'
X(6,:) = wavedata(1,[1:1000]);
load 'training_set/007-full'
X(7,:) = wavedata(1,[1:1000]);
load 'training_set/008-full'
X(8,:) = wavedata(1,[1:1000]);
load 'training_set/009-full'
X(9,:) = wavedata(1,[1:1000]);
load 'training_set/010-full'
X(10,:) = wavedata(1,[1:1000]);

y = [0; 0; 0; 0; 0; 1; 1; 1; 1; 1];

save 'train.mat' X y
