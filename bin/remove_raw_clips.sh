#!/bin/bash

################################################################################
# Remove all raw audio clips in the clips directory
#
# This is meant to be used on the rare occassion where you want to regenerate
# the RAW clips in a different way.
#
################################################################################


clipsDir=$FLERE_IMSAHO/data/audio/clips

#numberOfRAWFilesBefore=$(ls -l $clipsDir/*.raw | wc -l)
#numberOfMP3FilesBefore=$(ls -l $clipsDir/*.mp3 | wc -l)
numberOfRAWClipsBefore=$(ls -l $clipDir | grep '^-.*.raw' | wc -l)
numberOfMP3ClipsBefore=$(ls -l $clipDir | grep '^-.*.mp3' | wc -l)

cd $clipsDir

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

FILES=$(find -name "*.raw")

for file in $FILES
do
  rm ${file}
done

IFS=$SAVEIFS


################################################################################
# echo stats
################################################################################

#numberOfRAWFilesAfter=$(ls -l $clipsDir/*.raw | wc -l)
#numberOfMP3FilesAfter=$(ls -l $clipsDir/*.mp3 | wc -l)
numberOfRAWClipsAfter=$(ls -l $clipDir | grep '^-.*.raw' | wc -l)
numberOfMP3ClipsAfter=$(ls -l $clipDir | grep '^-.*.mp3' | wc -l)

echo "numberOfRAWFilesBefore = $numberOfRAWFilesBefore"
echo "numberOfRAWFilesAfter  = $numberOfRAWFilesAfter"
echo "numberOfMP3FilesBefore = $numberOfMP3FilesBefore"
echo "numberOfMP3FilesAfter  = $numberOfMP3FilesAfter"


