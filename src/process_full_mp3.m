
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
%   Environment variables:
%     FLERE_IMSAHO
%     PATH
%     WEIGHTS
%     PNG_DIR
%     RAW_FILE
%     PNG_FILE
%
% Output:
%   a PNG file illustrating the high and low intensity points in the song.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


tic;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enable the calling of our functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
functionDir = [getenv("FLERE_IMSAHO") "/src"];
fprintf("functionDir = %s\n", functionDir);
addpath (functionDir);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Process the command line arguments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mp3File            = [getenv("MP3_DIR") "/" getenv("MP3_FILE")];
rawFile            = [getenv("MP3_DIR") "/" getenv("RAW_FILE")];
pngFile            = [getenv("PNG_DIR") "/" getenv("PNG_FILE")];
weightsMatlabFile  = [getenv("WEIGHTS")];
rawFileNoExtension = rawFile(1:end-4);
csvFile            = [getenv("MP3_DIR") "/" getenv("MP3_FILE") ".csv"];

fprintf("           mp3File: %s\n", mp3File);
fprintf("           rawFile: %s\n", rawFile);
fprintf("           rawFile: %s\n", rawFileNoExtension);
fprintf("           pngFile: %s\n", pngFile);
fprintf(" weightsMatlabFile: %s\n", weightsMatlabFile);
fprintf("           csvFile: %s\n", csvFile);

time2Start = toc;

signalsPerClip=500;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load the data from the RAW audio file
% into a series of 1 second (500 data points)
% via a column vectotor called "songVector"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tic;

songVector = loadaudio(rawFileNoExtension, 'raw', 16);
printf("size(songVector,1):\n");
disp(size(songVector,1));

%fprintf("dimensions of songVector:\n");
%disp(size(songVector));

%fprintf("sample data from songVector:\n");
%for i = 5:8
%  startOfSample = i * signalsPerClip;
%  endOfSample   = startOfSample + 10;
%  fprintf("songVector(%d:%d,1): \n", startOfSample, endOfSample);
%  disp(songVector(startOfSample:endOfSample,1));
%end

time2LoadAudio = toc;

number_of_clips = idivide(size(songVector,1), signalsPerClip);

printf("number_of_clips:\n");
disp(number_of_clips);

tic;

startOfClip = 1;
endOfClip   = startOfClip + signalsPerClip - 1;
for i = 1:number_of_clips
  %fprintf("%d: start:%d, end:%d\n", i, startOfClip, endOfClip);
  X(i,1:signalsPerClip) = songVector(startOfClip:endOfClip,1);
  startOfClip = endOfClip + 1;
  endOfClip   = startOfClip + signalsPerClip - 1;
end

timeOfClipConstruction = toc;

% Did it work? Size matters! 
fprintf(" dimensions of X: %d x %d\n", size(X,1), size(X,2));

%fprintf("sample data from X:\n");
%for i = 5:8
%  fprintf("X(%d,1:10): \n", i);
%  disp(X(i,1:10));
%end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Use the neural net to make some predictions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Define the architecture of the neural net
input_layer_size  = signalsPerClip;
hidden_layer_size = 5;
num_labels        = 2;

% Load the neural network parameters that were trained in trainNN.m
% variables Theta1 and Theta2 should now contain the weights
fprintf('\nLoading da magical Neural Network Parameters ...\n')

tic;
load(weightsMatlabFile);

fprintf(" dimensions of Theta1: %d x %d\n", size(Theta1,1), size(Theta1,2));
fprintf(" dimensions of Theta2: %d x %d\n", size(Theta2,1), size(Theta2,2));

XNorm = featureNormalize(X);

pred1 = predict(Theta1, Theta2, XNorm);
%disp(pred1');
time2Predict = toc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Persist the extracted song data to a matlab data file.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%matlabSongFile = fullfile(getenv("FLERE_IMSAHO"), "data/matlab", "song.mat");
%disp(matlabSongFile);
%save(matlabSongFile, 'X', 'XNorm', '-v6');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate a summary plot of the song
% Plot contains 3 things:
% 1: The "normalized" wave form of the song.
%    By "normalized" we mean the range of values has been reduced
%    from (-2^16, +2^16) to (-1, +1).
% 2: Low Intensity Predictions
% 3: High Intensity Predictions
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tic;

setenv ("GNUTERM", "x11");
%imageFile = sprintf("%03d-%05d-%s.png", i, index(i), clipName{i});
%imageFile = [ outputDirectory "/" imageFile ];
%imageFile = "/Users/alexryan/alpine/git/flere-imsaho/data/audio/user/wtpwebapps/flereImsaho/plot.png"
%imageFile = [pngDirectory "/plot.png"];

fprintf("Writing: %s\n", pngFile);

normalizedSong   = XNorm(:);  % unroll the matrix into a vector for plotting

lowIndices       = find(pred1==1);
lowIndicesScaled = lowIndices * signalsPerClip;
lowValues        = [ones(size(lowIndices,1),1) * -0.5];

highIndices       = find(pred1==2);
highIndicesScaled = highIndices * signalsPerClip;
highValues        = [ones(size(highIndices,1),1) * 0.5];

h=figure;
plot(1:size(normalizedSong), normalizedSong, 'Color', 'green', 'LineWidth', 0.01);
hold on;
scatter(lowIndicesScaled, lowValues, 'filled');
scatter(highIndicesScaled, highValues);
title(getenv("PNG_FILE"), "fontsize", 12);
print(h, pngFile, '-dpng');
fprintf("PNG Written: %s\n", pngFile);

time2GeneratePNG = toc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate stats and store the results in a test file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%headers = {'low','high','percent_low','percent_high'};

tic;

low   = size(lowIndices,1);
high  = size(highIndices,1);
total = low + high;
pLow  = low / total;
pHigh = high / total;

%data = [low high pLow pHigh];

fprintf("Writing: %s\n", csvFile);
%disp(headers);
%disp(data);
%csvwrite_with_headers(csvFile, data, headers);

fid = fopen (csvFile,'wt');
fprintf(fid,'%s,%d,%d,%.10f,%.10f\n', getenv("MP3_FILE"),low, high, pLow, pHigh);
fclose(fid);

time2WriteCsv = toc;

fprintf("             time2Start=%f\n", time2Start);
fprintf("         time2LoadAudio=%f\n", time2LoadAudio);
fprintf(" timeOfClipConstruction=%f\n", timeOfClipConstruction);
fprintf("           time2Predict=%f\n", time2Predict);
fprintf("       time2GeneratePNG=%f\n", time2GeneratePNG);
fprintf("          time2WriteCsv=%f\n", time2WriteCsv);

