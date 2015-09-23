#!/bin/bash

################################################################################
# Remove all audio clips in the new-clips directory
#
# CAREFUL
#
# Don't run this until AFTER you have transfered MP3 and RAW clips to the "clips"
# directory.
#
################################################################################

echo "emptying the directory: $clipsDir"

clipsDir=$FLERE_IMSAHO/data/audio/new-clips

numberOfFilesBefore=$(ls -l $clipsDir | wc -l)

cd $clipsDir

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

numberOfFilesAfter=$(ls -l $clipsDir | wc -l)
echo "numberOfFilesBefore = $numberOfFilesBefore"
echo "numberOfFilesAfter  = $numberOfFilesAfter"
#ls -lF $FLERE_IMSAHO/data/audio/new-clips


