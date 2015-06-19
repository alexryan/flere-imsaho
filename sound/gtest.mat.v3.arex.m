%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% octave prepareTrainingData2.m
% ls -lF test2.mat
% octave
% >> load('test2.mat');
% >> size(T)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialization
clear ; close all; clc
cd test_set3

song1 = loadaudio('Adele-Someone_Like_You.mono-sr4000-ss8', 'raw', 8);
A(1,:) = song1(80001:84000,1);

song2 = loadaudio('Burning_Inside.mono-sr4000-ss8', 'raw', 8);
A(2,:) = song2(80001:84000,1);

song3 = loadaudio('Christopher_Cross-Sailing.mono-sr4000-ss8', 'raw', 8);
A(3,:) = song3(80001:84000,1);

song4 = loadaudio('Deicide-Kill_the_Christian.mono-sr4000-ss8', 'raw', 8);
A(4,:) = song4(80001:84000,1);

song5 = loadaudio('Disturbed-Down_With_The_Sickness.mono-sr4000-ss8', 'raw', 8);
A(5,:) = song4(80001:84000,1);

song6 = loadaudio('James_Blunt-Youre_Beautiful.mono-sr4000-ss8', 'raw', 8);
A(6,:) = song6(80001:84000,1);

song7 = loadaudio('John_Lennon-Imagine.mono-sr4000-ss8', 'raw', 8);
A(7,:) = song7(80001:84000,1);

song8 = loadaudio('Ministry-Primitive_Future.mono-sr4000-ss8', 'raw', 8);
A(8,:) = song8(80001:84000,1);

song8 = loadaudio('Rhiana-Diamonds.mono-sr4000-ss8', 'raw', 8);
A(9,:) = song8(80001:84000,1);

song8 = loadaudio('Sony_Hackers-you_are_an_idiot.mono-sr4000-ss8', 'raw', 8);
A(10,:) = song8(80001:84000,1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0 = low intensity
% 1 = high intensity
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b = [0; 1; 0; 1; 1; 0; 0; 1; 0; 1];

cd ..
save 'test3.mat' A b

