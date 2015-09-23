#!/bin/bash

################################################################################
# Cleanse the audio clips
#
# Run this after you have generated MP3 and RAW clips
# to save yourself a world of pain.
#
# This script detects raw files that are less than the size they are supposed to be.
# That means that the MP3 clip used to generate it was too short.
# Both of these must be deleted.
#
################################################################################

clipDir=$FLERE_IMSAHO/data/audio/new-clips

numberOfMP3ClipsBefore=$(ls -l $clipDir | grep '^-.*.mp3' | wc -l)
numberOfRAWClipsBefore=$(ls -l $clipDir | grep '^-.*.raw' | wc -l)

cd $clipDir

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")


echo -e "\nRemoving MP3 files of size 0 bytes  ..."
FILES=$(find -name "*.mp3" -size -418c)
for file in $FILES
do
  ls -lF ${file}
  rm ${file}  
done

################################################################################
# First find the RAW files that are below the required size.
# Then remove both the RAW file and the MP3 file from which it was generated.
################################################################################
echo -e  "\nRemoving MP3 and RAW files that are TOO SHORT ..."
FILES=$(find -name "*.raw" -size -2012c)
for file in $FILES
do
  ls -lF ${file}
  name=${file%%.mono-sr0500-ss16.raw}
  ls -lF ${name}.mp3
  rm ${name}.mp3
  rm ${file}
done

IFS=$SAVEIFS


################################################################################
# echo stats
################################################################################

numberOfRAWClipsAfter=$(ls -l $clipDir | grep '^-.*.raw' | wc -l)
numberOfMP3ClipsAfter=$(ls -l $clipDir | grep '^-.*.mp3' | wc -l)

echo "numberOfMP3ClipsBefore = $numberOfMP3ClipsBefore"
echo "numberOfRAWClipsBefore = $numberOfRAWClipsBefore"
echo "numberOfMP3ClipsAfter  = $numberOfMP3ClipsAfter"
echo "numberOfRAWClipsAfter  = $numberOfRAWClipsAfter"

