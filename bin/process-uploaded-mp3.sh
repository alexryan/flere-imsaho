#!/bin/bash

################################################################################
# This script is meant to be called from a servlet
# imediately after the servlet has deposited an MP3 file onto the file system
# for processing.
# The purpose of this script is to generate the intesity profile of the song.
# We chop the song up into 2 second segments
# run each through the neural net to out the intensity prediction for each
# then write the complete series of predictions to a file.
# Currently, our neural net can only predict low and high intensities.
# So the output file will contain a series of 1's and 2's.
#
# Pre-requisites:
#   The following environment variables must be set:
#
# MP3_DIR:
#   Directory containing the MP3 file to be processed.
#   A RAW file will be generated here by this script.
# MP3_FILE
#   The name of the MP3 file that gets written to the directory by the servlet.
# RAW_FILE
#   The name of the RAW file that we will generate from the MP3 file using sox.
# PNG_DIR
#   The directory to which this script should write the PNG file.
# PNG_FILE
#   The name of the PNG file that will will generate from the RAW file using octave.
# FLERE_IMSAHO
#   The home directory of the FLERE_IMSAHO project on this machine
# PATH
#   Must contain access to all of the executables needed to run this script:
#   sox, octave, fig2dev, etc.
# WEIGHTS
#   The magical matlab file containing a set of weights (matrices) for the
#   neural net to prcess and make predictions.
#
################################################################################

# Check that environment variables have been properly set
set

if [ -z "$FLERE_IMSAHO" ]; then
  printf "FLERE_IMSAHO environment variable is not set.\n"
  exit 0
fi
#printf"FLERE_IMSAHO=$FLERE_IMSAHO\n"

if [ -z "$MP3_DIR" ]; then
  printf "MP3_DIR environment variable is not set.\n"
  exit 0
fi

if [ -z "$MP3_FILE" ]; then
  printf "MP3_FILE environment variable is not set.\n"
  exit 0
fi

if [ -z "$RAW_FILE" ]; then
  printf "RAW_FILE environment variable is not set.\n"
  exit 0
fi

if [ -z "$PNG_DIR" ]; then
  printf "PNG_DIR environment variable is not set.\n"
  exit 0
fi

if [ -z "$PNG_FILE" ]; then
  printf "PNG_FILE environment variable is not set.\n"
  exit 0
fi

if [ -z "$WEIGHTS" ]; then
  printf "WEIGHTS environment variable is not set.\n"
  exit 0
fi

if ! type sox > /dev/null; then
  printf "sox is not accessible in PATH\n
  exit 0
fi

if ! type octave > /dev/null; then
  printf "octave is not accessible in PATH\n
  exit 0
fi

###############################################################################
# Extract multiple short clips
# These clips must be long enough that a human can listen to and
# judge its intensity or valence relative to another snippet
################################################################################

echo 'generating new audio clips ...'
cd $MP3_DIR
#rm *.raw

#name=${MP3%%.mp3}
#echo "name=$name"

#/usr/local/bin/sox userfile.mp3 -c 1 -r 500 --bits 16 userfile.mono-sr0500-ss16.raw
#sox userfile.mp3 --channels 1 -r 500 --bits 16 userfile.mono-sr0500-ss16.raw
sox userfile.mp3 --channels 1 -r 500 --bits 16 $RAW_FILE

echo "Did sox run"
#ls -lF *.raw
ls -lF $RAW_FILE

################################################################################
# Convert the generated RAW file to a series of predictions
################################################################################
OCTAVE_PATH=$FLERE_IMSAHO/src
##/usr/local/bin/octave --path $OCTAVE_PATH $FLERE_IMSAHO/src/process_full_mp3.m
##octave --path $OCTAVE_PATH $FLERE_IMSAHO/src/process_full_mp3.m

echo "running the octave script ..."
#$FLERE_IMSAHO/src/process_full_mp3.m $MP3_DIR $PNG_DIR $WEIGHTS
$FLERE_IMSAHO/src/process_full_mp3.m

echo "done"



