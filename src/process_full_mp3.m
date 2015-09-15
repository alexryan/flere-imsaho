%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% process_full_mp3.m
% The purpose of this script is to generate the intesity profile of a full song.
% Ths song is available in RAW format here
%   $FLERE_IMSAHO/data/audio/user/userfile.mono-sr4000-ss16.raw
% We chop the song up into 2 second segments
% run each through the neural net to out the intensity prediction for each
% then write the complete series of predictions to a file.
% Currently, our neural net can only predict low and high intensities.
% So the output file will contain a series of 1's and 2's.
%
% Input:
%   $FLERE_IMSAHO/data/audio/user/userfile.mono-sr4000-ss16.raw
%
% Output:
%   $FLERE_IMSAHO/data/audio/user/userfile.time-series.dat
%
%   $FLERE_IMSAHO/data/matlab/user.mat
%   Store a backup of the extracted data in a matlab file.
%   Varibles: X: a 4000x? matrix
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialization
clear ; close all; clc

rawFile = [getenv("FLERE_IMSAHO") "/data/audio/user/userfile.mono-sr4000-ss16"];
printf("rawFile=%s\n", rawFile);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load the data from the RAW audio file
% into a ?x4000 matrix called X.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

songVector = loadaudio(rawFile, 'raw', 16);
printf("size(songVector,1):\n");
disp(size(songVector,1));

%number_of_clips = size(songVector,1)/4000;
number_of_clips = idivide(size(songVector,1), 4000);
printf("number_of_clips:\n");
disp(number_of_clips);

for i = 1:number_of_clips
  start_of_clip = i * 4000;
  end_of_clipe  = start_of_clip + 4000;
  X(i,:) = songVector(1:4000,1);
end

% Did it work? Size matters! 

fprintf(" dimensions of X: %d x %d\n", size(X,1), size(X,2));

printf("paused");
pause;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Use the neural net to make some predictions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Define the architecture of the neural net
input_layer_size  = 4000;  % 20x20 Input Images of Digits
hidden_layer_size = 10;    % 25 hidden units
num_labels = 2;            % 2 labels: {1,2}

% Load the neural network parameters that were trained in trainNN.m
% variables Theta1 and Theta2 should now contain the weights
fprintf('\nLoading da magical Neural Network Parameters ...\n')
load('/Users/alexryan/alpine/git/flere-imsaho/data/matlab/flere-imsaho-weights.mat');
fprintf(" dimensions of Theta1: %d x %d\n", size(Theta1,1), size(Theta1,2));
fprintf(" dimensions of Theta2: %d x %d\n", size(Theta2,1), size(Theta2,2));

pred1 = predict(Theta1, Theta2, X);
disp(pred1');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Persist the extracted song data to a matlab data file.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

matlabSongFile = fullfile(getenv("FLERE_IMSAHO"), "data/matlab", "song.mat");
disp(matlabSongFile);
save(matlabSongFile, 'X', '-v6');

