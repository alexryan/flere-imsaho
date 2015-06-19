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

song1 = loadaudio('001-A_Thousand_Years.mono-sr4000-ss16', 'raw', 8);
%X(1,:) = song1(40001:44000,1);
X(1,:) = song1(40001:44000,1);
X(2,:) = song1(44001:48000,1);

song2 = loadaudio('002-The_Cello_Song-Bach_is_back.mono-sr4000-ss16', 'raw', 8);
%X(2,:) = song2(40001:44000,1);
X(3,:) = song2(40001:44000,1);
X(4,:) = song2(44001:48000,1);

song3 = loadaudio('003-Devi_Prayer.mono-sr4000-ss16', 'raw', 8);
%X(3,:) = song3(40001:44000,1);
X(5,:) = song3(40001:44000,1);
X(6,:) = song3(44001:48000,1);

song4 = loadaudio('004-Sammasati.mono-sr4000-ss16', 'raw', 8);
%X(4,:) = song4(40001:44000,1);
X(7,:) = song4(40001:44000,1);
X(8,:) = song4(44001:48000,1);

song5 = loadaudio('005-The_Girl_From_Ipanema.mono-sr4000-ss16', 'raw', 8);
%X(5,:) = song5(40001:44000,1);
X(9,:) = song5(40001:44000,1);
X(10,:) = song5(44001:48000,1);

song6 = loadaudio('006_Gasolina.mono-sr4000-ss16', 'raw', 8);
%X(6,:) = song6(40001:44000,1);
X(11,:) = song6(40001:44000,1);
X(12,:) = song6(44001:48000,1);

song7 = loadaudio('007_Crazy_Bitch.mono-sr4000-ss16', 'raw', 8);
%X(7,:) = song7(40001:44000,1);
X(13,:) = song7(40001:44000,1);
X(14,:) = song7(44001:48000,1);

song8 = loadaudio('008_Mortal_Kombat_Theme_Song.mono-sr4000-ss16', 'raw', 8);
%X(8,:) = song8(40001:44000,1);
X(15,:) = song8(40001:44000,1);
X(16,:) = song8(44001:48000,1);

song9 = loadaudio('009_Fuck_It_All.mono-sr4000-ss16', 'raw', 8);
%X(9,:) = song9(40001:44000,1);
X(17,:) = song9(40001:44000,1);
X(18,:) = song9(44001:48000,1);

song10 = loadaudio('010_Fucking_Hostile.mono-sr4000-ss16', 'raw', 8);
%X(10,:) = song10(40001:44000,1);
X(19,:) = song10(40001:44000,1);
X(20,:) = song10(44001:48000,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0 = low intensity
% 1 = high intensity
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%y = [0; 0; 0; 0; 0; 1; 1; 1; 1; 1];
y = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1];

cd ..
save 'train2.mat' X y

