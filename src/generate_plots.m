#!/usr/local/bin/octave -qf

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% generate-plots.m
%
% Generate a series of plots as PNG files.
%
% Input parameters
% (1) matrix
%     Which of the 3 matrices are we grabbing the data from?
%     value: one of Xtrain or Xval or Xtest
% (2) rows
%     Which rows of the matrix are we grabbing the data from?
%     value: full path to the sorted prediction file
%     first column of this file contains the indices
%     Example:
#       /Users/alexryan/alpine/git/flere-imsaho/data/playlists/output/test-set-true-positives-with-indices.csv
% (3) directory
%     Which file system directory are we actually writing the PNG files to?
%     value: full path the directory where the PNG files should be written
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enable the calling of our functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
functionDir = [getenv("FLERE_IMSAHO") "/src"];
fprintf("functionDir = %s\n", functionDir);
addpath (functionDir);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load the raw data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global Xtrain;
global ytrain;
global Xval;
global yval;
global Xtest;
global ytest;
loadData;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Process the command line arguments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

args = argv ();

if (length(args) != 3)
  fprintf("expected 3 paramaters. got this many: %d\n", length(args));
  break;
end

%for k=1:length(args)
%  arg=args{k};
%  fprintf("%d:%s\n", k, arg);
%end

if (strcmp("Xtrain", args{1}))
  %fprintf("It's Xtrain!\n");
  matrix=Xtrain;
elseif (strcmp("Xval", args{1}))
  %fprintf("It's Xval!\n");
  matrix=Xval;
elseif (strcmp("Xtest", args{1}))
  %fprintf("It's Xtest!\n");
  matrix=Xtest;
else
  fprintf("%s: this is not a valid data set.\n", args{1});
  break;
end

matrixName      = args{1};
predictionFile  = args{2};
outputDirectory = args{3};

fprintf("      matrixName: %s\n", matrixName);
fprintf("  predictionFile: %s\n", predictionFile);
fprintf(" outputDirectory: %s\n", outputDirectory);


disp(size(matrix));
disp(size(matrix(1,:)));


%break;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Loop through the records of the csv file.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[index, clipName, actual, prediction, p1, p2] = ...
  textread(predictionFile, "%d %s %d %d %f %f", "delimiter", ",", "headerlines", 1);

%fileID = fopen(predictionFile);
%formatSpec = '%d %s %d %d %f %f';
%N = 2;
%[index, clipName, actual, prediction, p1, p2] = textscan(fileID,formatSpec,N,'Delimiter',',');

%setenv ("GNUTERM", "png")
setenv ("GNUTERM", "x11")
%close all
%graphics_toolkit gnuplot 

for i=1:20
  fprintf("index=%d, clipName=%s\n", index(i), clipName{i});

    imageFile = sprintf("%03d-%05d-%s.png", i, index(i), clipName{i});
    imageFile = [ outputDirectory "/" imageFile ];
    fprintf("Writing: %s\n", imageFile);

    %x = 0:pi/100:2*pi;
    %y = sin(x);
    h=figure;
    %plot(x,y);
    y=matrix(index(1),:);
    x=1:length(y);
    plot(x,y);
    title(clipName{i}, "fontsize", 12); 
    print(h, imageFile, '-dpng');
    close all;
    
end

%fclose(fileID);




