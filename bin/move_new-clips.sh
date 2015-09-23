#!/bin/bash

################################################################################
# Move clips from the new-clips to the clips directory
#
# Don't do this until ...
# > RAW files have been generated
# > Unusable MP3 & RAW clips have been cleansed
# > MP3 clips have been loaded into iTunes
#
################################################################################

sourceDir=$FLERE_IMSAHO/data/audio/new-clips
targetDir=$FLERE_IMSAHO/data/audio/clips

numberOfFilesBeforeInSource=$(ls -l $sourceDir | wc -l)
numberOfFilesBeforeInTarget=$(ls -l $targetDir | wc -l)

cd $sourceDir

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

FILES=$(find -name "*")

for file in $FILES
do
  mv ${file} $targetDir
done

IFS=$SAVEIFS


################################################################################
# echo stats
################################################################################

numberOfFilesAfterInSource=$(ls -l $sourceDir | wc -l)
numberOfFilesAfterInTarget=$(ls -l $targetDir | wc -l)

echo " sourceDir = $sourceDir"
echo " targetDir = $targetDir"
echo "numberOfFilesBeforeInSource = $numberOfFilesBeforeInSource"
echo "numberOfFilesBeforeInTarget = $numberOfFilesBeforeInTarget"
echo "numberOfFilesAfterInSource  = $numberOfFilesAfterInSource"
echo "numberOfFilesAfterInTarget  = $numberOfFilesAfterInTarget"

