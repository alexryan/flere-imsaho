#!/bin/bash

################################################################################
# Clean the audio clips
#
# Run this script BEFORE you import your MP3 files into iTunes
# to save yourself a world of pain.
#
# This script detects raw files that are less than the size they are supposed to be.
# That means that the MP3 clip used to generate it was too short.
# Both of these must be deleted.
#
################################################################################

echo 'emptying the new-clips directory ...'

numberOfFilesBefore=$(ls -l $FLERE_IMSAHO/data/audio/new-clips | wc -l)

cd $FLERE_IMSAHO/data/audio/new-clips

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

FILES=$(find -name "*")

for file in $FILES
do
  rm ${file}
done

IFS=$SAVEIFS


################################################################################
# echo stats
################################################################################

numberOfFilesAfter=$(ls -l $FLERE_IMSAHO/data/audio/new-clips | wc -l)
echo "numberOfFilesBefore = $numberOfFilesBefore"
echo "numberOfFilesAfter  = $numberOfFilesAfter"
#ls -lF $FLERE_IMSAHO/data/audio/new-clips


