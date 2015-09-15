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
################################################################################

echo "$(date) : Adding some content to a file" >> $FLERE_IMSAHO/bin/catchMe.txt

MP3_DIR=$FLERE_IMSAHO/data/audio/user
MP3=userfile.mp3

###############################################################################
# Extract multiple short clips
# These clips must be long enough that a human can listen to and
# judge its intensity or valence relative to another snippet
################################################################################

echo 'generating new audio clips ...'
cd $MP3_DIR

name=${MP3%%.mp3}
sox ${name}.mp3 -c 1 -r 4000 --bits 16 ${name}.mono-sr4000-ss16.raw




