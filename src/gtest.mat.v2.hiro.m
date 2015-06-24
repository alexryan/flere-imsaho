%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% octave prepareTrainingData2.m
% ls -lF test2.mat
% octave
% >> load('test2.mat');
% >> size(T)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialization
clear ; close all; clc
cd test_set2

song1 = loadaudio('001-Beautiful_Day.mono-sr4000-ss8', 'raw', 8);
A(1,:) = song1(40001:41000,1);

song2 = loadaudio('002-Zoo_Station.mono-sr4000-ss8', 'raw', 8);
A(2,:) = song2(40001:41000,1);

song3 = loadaudio('003-I_Wont_Forget_You.mono-sr4000-ss8', 'raw', 8);
A(3,:) = song3(40001:41000,1);

song4 = loadaudio('004-Cemetery_Gates.mono-sr4000-ss8', 'raw', 8);
A(4,:) = song4(40001:41000,1);

song5 = loadaudio('005-Left-Handed_Drummer_1.mono-sr4000-ss8', 'raw', 8);
A(5,:) = song5(120001:121000,1);

song6 = loadaudio('006-Lovers_In_Japan.mono-sr4000-ss8', 'raw', 8);
A(6,:) = song6(40001:41000,1);

song7 = loadaudio('007-Fallen_Angel.mono-sr4000-ss8', 'raw', 8);
A(7,:) = song7(40001:41000,1);

song8 = loadaudio('008-Did_You_No_Wrong.mono-sr4000-ss8', 'raw', 8);
A(8,:) = song8(40001:41000,1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0 = low intensity
% 1 = high intensity
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b = [1; 0; 0; 0; 1; 0; 0; 0];

cd ..
save 'test2.mat' A b

