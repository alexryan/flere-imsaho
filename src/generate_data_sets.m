%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% generate-data-sets.m
%
% Process a bunch of audio files and generate 3 data sets for machine learning:
% in 3 different Matlab data files:
%
% (1) a training set (~60%)
%     variables: Xtrain, ytrain
%     file: flere-imsaho-train.mat
%
% (2) a cross validation set (~20%)
%     variables: Xval, yval
%     file: flere-imsaho-val.mat
%
% (3) a training set (~20%)
%     variables: Xtest, ytest
%     file: flere-imsaho-test.mat
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Usage:
%
% octave generate_data_sets.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% What you get ...
%
% After running this script, a Matlab file will magically appear here:
%   $FLERE_IMSAHO/data/matlab/flere-imsaho-train.mat'
%   $FLERE_IMSAHO/data/matlab/flere-imsaho-val.mat'
%   $FLERE_IMSAHO/data/matlab/flere-imsaho-test.mat' 
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pre-requisites:
%
%   (1) csv containing list of audio files o be processed and their labels exists here:
%     $FLERE_IMSAHO/data/audio/experiment.withLabels.csv
%   (2) actual audio files exist here:
%     $FLERE_IMSAHO/data/audio/clips
% This script requires the installation of the io package from octave-forge.
% >> pkg install -forge io
% >> pkg list
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Did it work???
% Here's how to find out ...
%
% # cd $FLERE_IMSAHO/data/matlab
% # ls -lF flere-imsaho-*.mat
% See 3 files?
%
% # octave
% >> load('flere-imsaho');
% >> size(Xtrain)
% >> size(ytrain)
% >> plot(Xtrain(24,400:600))
%
% >> load('flere-imsaho-test');
% >> size(Xtest)
% >> size(ytest)
% >> plot(Xtest(24,400:600))
%
% If you see stuff, it probably worked.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functionDir = [getenv("FLERE_IMSAHO") "/src"];
fprintf("functionDir = %s\n", functionDir);

addpath (functionDir);
%path

pkg load io;
%% Initialization
clear ; close all; clc


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get the full paths to
% input files & directories
% and output files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

csvFile              = [getenv("FLERE_IMSAHO") "/data/playlists/flere-imsaho.csv"];
path2RawSongFiles    = [getenv("FLERE_IMSAHO") "/data/audio/clips"];

trainingSetCsvFile   = [getenv("FLERE_IMSAHO") "/data/matlab/training-set.csv"];
validationSetCsvFile = [getenv("FLERE_IMSAHO") "/data/matlab/validation-set.csv"];
testSetCsvFile       = [getenv("FLERE_IMSAHO") "/data/matlab/test-set.csv"];

matlabTrainingFile   = fullfile(getenv("FLERE_IMSAHO"), "data/matlab", "flere-imsaho-train.mat");
matlabValidationFile = fullfile(getenv("FLERE_IMSAHO"), "data/matlab", "flere-imsaho-val.mat");
matlabTestFile       = fullfile(getenv("FLERE_IMSAHO"), "data/matlab", "flere-imsaho-test.mat");


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Loop through the records of the csv file.
% Each record contains the name of the mp3 file and a label for it, like so:
%   Divinity-Ethereal_Void.40,1
%   Divinity-Ethereal_Void.50,1
%   ...
%   Pantera-Fucking_Hostile.50,2
%   Pantera-Fucking_Hostile.60,3
% Read the name of the audio file in the cell array "songs".
% Read the label into the vector "labels".
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[songs, labels] = textread(csvFile, "%s %f", "delimiter", ",");

% Did it work?
%printf("contents of %s\n", csvFile);
%disp(songs(1:10,:));
%disp(labels(1:10,:))
%printf("paused");
%pause;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% songs(i)  contains the "file name" for the ith song.
% labels(i) contains the "label" for the ith song.
%
% We want to the raw audio data in the file identified by songs(i).
%
% We want to loop through this structure,
% extracting the raw audio data
% and randomly placing it into one of 3 feature matrices:
% Xtrain, Xval, Xtest.
% We will also place the label in the corresponding label vector:
% ytrain, yval, ytest.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
trainingIndex   = 1;
validationIndex = 1;
testIndex       = 1;

numberOfClass1InTraining   = 0;
numberOfClass2InTraining   = 0;
numberOfClass1InValidation = 0;
numberOfClass2InValidation = 0;
numberOfClass1InTest       = 0;
numberOfClass2InTest       = 0;

trainingSetCsv   = {};
validationSetCsv = {};
testSetCsv       = {};

tic;
for i = 1:length(songs)

  %printf("i=%d\n", i);
  %printf("song=%s\n", songs{i,1});
  raw = [songs{i,1} ".mono-sr0500-ss16"];
  %printf("raw=%s\n", raw);
  raw = [path2RawSongFiles "/" raw];
  printf("raw=%s\n", raw);
  songVector = loadaudio(raw, 'raw', 16);
  randomNumber = randi([1e1 1e2],1,1);

  if (randomNumber < 80)
    %printf("%d goes to the training set\n", i);
    Xtrain(trainingIndex,:) = songVector(101:900,1);
    ytrain(trainingIndex,1) = labels(i);

    trainingSetCsv{trainingIndex,1} = songs{i,1};
    trainingSetCsv{trainingIndex,2} = labels(i);

    if (labels(i)==1)
      numberOfClass1InTraining = numberOfClass1InTraining + 1;
    else
      numberOfClass2InTraining = numberOfClass2InTraining + 1;
    end

    trainingIndex = trainingIndex + 1;
    
  elseif (randomNumber > 90)
    %printf("%d goes to the cross validation set\n", i);
    Xval(validationIndex,:) = songVector(101:900,1);
    yval(validationIndex,1) = labels(i);

    validationSetCsv{validationIndex,1} = songs{i,1};
    validationSetCsv{validationIndex,2} = labels(i);

    if (labels(i)==1)
      numberOfClass1InValidation = numberOfClass1InValidation + 1;
    else
      numberOfClass2InValidation = numberOfClass2InValidation + 1;
    end

    validationIndex = validationIndex + 1;
    
  else
    %printf("%d goes to the test set\n", i);
    Xtest(testIndex,:) = songVector(101:900,1);
    ytest(testIndex,1) = labels(i);

    testSetCsv{testIndex,1} = songs{i,1};
    testSetCsv{testIndex,2} = labels(i);

    if (labels(i)==1)
      numberOfClass1InTest = numberOfClass1InTest + 1;
    else
      numberOfClass2InTest = numberOfClass2InTest + 1;
    end

    testIndex = testIndex + 1;
    
  endif

end
timeElapsed = toc;
fprintf(" timeElapsed=%d\n", timeElapsed);

% Did it work? Size matters! 

fprintf(" dimensions of Xtrain: %d x %d\n", size(Xtrain,1), size(Xtrain,2));
fprintf(" dimensions of ytrain: %d x %d\n", size(ytrain,1), size(ytrain,2));
fprintf(" number of low intensity samples  = %d\n", numberOfClass1InTraining);
fprintf(" number of high intensity samples = %d\n", numberOfClass2InTraining);

fprintf(" dimensions of Xval: %d x %d\n", size(Xval,1), size(Xval,2));
fprintf(" dimensions of yval: %d x %d\n", size(yval,1), size(yval,2));
fprintf(" number of low intensity samples  = %d\n", numberOfClass1InValidation);
fprintf(" number of high intensity samples = %d\n", numberOfClass2InValidation);

fprintf(" dimensions of Xtest: %d x %d\n", size(Xtest,1), size(Xtest,2));
fprintf(" dimensions of ytest: %d x %d\n", size(ytest,1), size(ytest,2));
fprintf(" number of low intensity samples  = %d\n", numberOfClass1InTest);
fprintf(" number of high intensity samples = %d\n", numberOfClass2InTest);


printf("Paused. Hit Enter to generate the new .mat files.\n");
pause;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Persist the traiing data and test dat to matlab files.
% Example:
%   save '/Users/alexryan/alpine/git/flere-imhaso/data/matlab/flere-imsaho-train.mat' Xtrain ytrain
%   save '/Users/alexryan/alpine/git/flere-imhaso/data/matlab/flere-imsaho-val.mat' Xval yval
%   save '/Users/alexryan/alpine/git/flere-imhaso/data/matlab/flere-imsaho-test.mat' Xtest ytest
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Xtrain = featureNormalize(Xtrain);
Xval   = featureNormalize(Xval);
Xtest  = featureNormalize(Xtest);

save(matlabTrainingFile, 'Xtrain', 'ytrain', '-v6');
save(matlabValidationFile, 'Xval', 'yval', '-v6');
save(matlabTestFile, 'Xtest', 'ytest', '-v6');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Persist the record of exactly which clips were loaded into which data set
% in which order to CSV files.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cell2csv(trainingSetCsvFile, trainingSetCsv); 
cell2csv(validationSetCsvFile, validationSetCsv); 
cell2csv(testSetCsvFile, testSetCsv); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Print out the locations of the output files that have been written.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

printf("        inputCsvFile = %s\n", csvFile);
printf("   path2RawSongFiles = %s\n", path2RawSongFiles);

printf("  trainingSetCsvFile = %s\n", trainingSetCsvFile);
printf("validationSetCsvFile = %s\n", validationSetCsvFile);
printf("      testSetCsvFile = %s\n", testSetCsvFile);

printf("  matlabTrainingFile = %s\n", matlabTrainingFile);
printf("matlabValidationFile = %s\n", matlabValidationFile);
printf("      matlabTestFile = %s\n", matlabTestFile);

