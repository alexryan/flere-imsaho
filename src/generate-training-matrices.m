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
%   $FLERE_IMSAHO/data/matlab/experiment-train.mat' 
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
%     $FLERE_IMSAHO/data/audio/experiment.csv
%   (2) actual audio files exist here:
%     $FLERE_IMSAHO/data/audio/snippets
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Did it work???
% Here's how to find out ...
%
% cd $FLERE_IMSAHO/data/matlab
% ls -lF experiment-train.mat
% octave
% >> load('experiment-training');
% >> size(X)
% >> size(y)
% >> plot(X(24,400:600))
% >> load('experiment-test');
% >> size(A)
% >> size(b)
% >> plot(A(24,400:600))
%
% If you see stuff, it probably worked.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialization
clear ; close all; clc

csvFile = [getenv("FLERE_IMSAHO") "/data/audio/experiment.csv"]
%disp(csvFile)
printf("csvFile=%s\n", csvFile);

path2RawSongFiles = [getenv("FLERE_IMSAHO") "/data/audio/snippets"]
%disp(path2RawSongFiles)
printf("path2RawSongFiles=%s\n", path2RawSongFiles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Loop through the records of the csv file.
% Each record contains the name of the mp3 file and a label for it, like so:
%   Divinity-Ethereal_Void.40,0
%   Divinity-Ethereal_Void.50,0
%   ...
%   Pantera-Fucking_Hostile.50,1
%   Pantera-Fucking_Hostile.60,1
% Read the name of the audio file in the cell array "songs".
% Read the label into the vector "labels".
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[songs, labels] = textread(csvFile, "%s %f", "delimiter", ",");

% Did it work?
printf("contesnts of %s\n", csvFile);
disp(songs)
disp(labels)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Now the labels have been read into the vector y.
% We just need the raw audio data to be extacted from the files
% and injected into the matrix "X".
% Do that now.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
trainingIndex = 1;
testIndex = 1;
for i = 1:length(songs)

  printf("i=%d\n", i);
  printf("song=%s\n", songs{i,1});

  raw = [songs{i,1} ".mono-sr4000-ss16"]
  printf("raw=%s\n", raw);

  raw = [path2RawSongFiles "/" raw]
  printf("raw=%s\n", raw);

  songVector = loadaudio(raw, 'raw', 16);

  randomNumber = randi([1e1 1e2],1,1)

  if (randomNumber < 80)
    printf("%d goes to the training set\n", i);
    X(trainingIndex,:) = songVector(1:1000,1);
    y(trainingIndex) = labels(i);
    trainingIndex = trainingIndex + 1;
  else
    printf("%d goes to the test set\n", i);
    A(testIndex,:) = songVector(1:1000,1);
    b(testIndex) = labels(i);
    testIndex = testIndex + 1;
  endif

end

% Did it work? Size matters! 
printf("size of training set:\n")
disp(size(X))
printf("size of test set:\n")
disp(size(A))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Persist the traiing data and test dat to matlab files.
% Example:
%   save '/Users/alexryan/alpine/git/flere-imhaso/data/matlab/experiment-training.mat' X y
%   save '/Users/alexryan/alpine/git/flere-imhaso/data/matlab/experiment-test.mat' X y
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

matlabTrainingFile = fullfile(getenv("FLERE_IMSAHO"), "data/matlab", "experiment-training.mat")
disp(matlabTrainingFile)
save(matlabTrainingFile, 'X', 'y')

matlabTestFile = fullfile(getenv("FLERE_IMSAHO"), "data/matlab", "experiment-test.mat")
disp(matlabTestFile)
save(matlabTestFile, 'A', 'b')

