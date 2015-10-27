#!/usr/bin/env octave -qf

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% generate_plots_for_N_specified_clips.m
%
% Take a text file listing a series of audio clips we wish to generate plots
% for in the PNG format.
%
% $NEW_PNG_LIST points to an input text file 
% that may look something like this ...
%   $head -n 3 /tmp/new-pngs.dat
%   112-Peaches_and_Cream.30
%   112-Peaches_and_Cream.40
%   112-Peaches_and_Cream.50
%
% in the $MP3_DIR directory
% raw files for each of these like so ...
%   112-Peaches_and_Cream.30.mono-sr0500-ss16.raw
%   112-Peaches_and_Cream.40.mono-sr0500-ss16.raw
%   112-Peaches_and_Cream.50.mono-sr0500-ss16.raw
%
% it is the responsibility of the caller 
% Generate a series of plots as PNG files.
%
% If these conditions are satisfied, this program will generate the specified
% PNG files in the $PNG_DIR
%
% It is the responsibility of the caller to ensure that all the desired PNG files
% have been correctly generated.
%
% Pre-requisites:
%   These environment variables must be set to correct values:
%     NEW_PNG_LIST
%     MP3_DIR
%     PNG_DIR
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get input parameters from enviornment variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
functionDir    = [getenv("FLERE_IMSAHO") "/src"];
newPngList     = getenv("NEW_PNG_LIST");
mp3Dir         = getenv("MP3_DIR");
pngDir         = getenv("PNG_DIR");
matlabTempFile = getenv("MATLAB_TEMP_FILE");

fprintf("   functionDir = %s\n", functionDir);
fprintf("    newPngList = %s\n", newPngList);
fprintf("        mp3Dir = %s\n", mp3Dir);
fprintf("        pngDir = %s\n", pngDir);
fprintf("matlabTempFile = %s\n", pngDir);


if (length(newPngList) < 1)
  fprintf("ERROR: $NEW_PNG_LIST=|%s|\n", newPngList);
  break;
end
if (length(mp3Dir) < 1)
  fprintf("ERROR: MP3_DIR=|%s|\n", mp3Dir);
  break;
end
if (length(pngDir) < 1)
  fprintf("ERROR: PNG_DIR=|%s|\n", pngDir);
  break;
end
if (length(matlabTempFile) < 1)
  fprintf("ERROR: MATLAB_TEMP_FILE=|%s|\n", pngDir);
  break;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enable the calling of our functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath (functionDir);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load the raw data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Loop through the records of the csv file.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[clipName] =  textread(newPngList, "%s");

fprintf("How big is that list?");
disp(size(clipName));

numberOfPNGs2Generate = size(clipName,1);

%setenv ("GNUTERM", "png")
setenv ("GNUTERM", "x11")
%close all
%graphics_toolkit gnuplot 

myMatrix = zeros(20,500);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Phase 1: Generate the Matrix
% i.e. Pull audio data from the RAW files into rows of the matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tic;
for i=1:numberOfPNGs2Generate
  fprintf("clipName=%s\n", clipName{i});

  rawFile = sprintf("%s.mono-sr0500-ss16", clipName{i});
  fprintf("rawFile=%s\n", rawFile);

  rawFile = [ mp3Dir "/" rawFile];
  fprintf("rawFile=%s\n", rawFile);
  
  imageFile = sprintf("%s.png", clipName{i});
  fprintf("imageFile=%s\n", imageFile);

  imageFile = [ pngDir "/" imageFile ];
  fprintf("imageFile=%s\n", imageFile);

  % Read the data from the raw file
  songVector = loadaudio(rawFile, 'raw', 16);
  myMatrix(i,:) = songVector(101:600,1);
  
  
    %%x = 0:pi/100:2*pi;
    %%y = sin(x);
    %h=figure;
    %%plot(x,y);
    %y=matrix(index(i),:);
    %x=1:length(y);
    %plot(x,y);
    %title(clipName{i}, "fontsize", 12); 
    %print(h, imageFile, '-dpng');
    %close all;
    
end

time2GenerateMatrix = toc;

% Normalize
myMatrix = featureNormalize(myMatrix);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Phase 2: Generate the PNGs ...
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tic;
for i=1:numberOfPNGs2Generate
  fprintf("clipName=%s\n", clipName{i});

  imageFile = sprintf("%s.png", clipName{i});
  fprintf("imageFile=%s\n", imageFile);

  imageFile = [ pngDir "/" imageFile ];
  fprintf("imageFile=%s\n", imageFile);

  h=figure;
  plot(myMatrix(i,:));
  title(clipName{i}, "fontsize", 12); 
  print(h, imageFile, '-dpng');
  close all;
end
time2GeneratePNGs = toc;

fprintf(" time2GenerateMatrix=%d\n", time2GenerateMatrix);
fprintf("   time2GeneratePNGs=%d\n", time2GeneratePNGs);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Persist the traiing data and test dat to matlab files.
% Example:
%   save '/Users/alexryan/alpine/git/flere-imhaso/data/matlab/flere-imsaho-temp.mat' myMatrix
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save(matlabTempFile, 'myMatrix', '-v6');

