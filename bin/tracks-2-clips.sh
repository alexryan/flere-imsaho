#!/bin/bash

################################################################################
# Take multiple audio clips from every MP3 file in
# $FLERE_IMSAHO/data/audio/tracks
# and place it them in
# $FLERE_IMSAHO/data/audio/clips
# as .raw files.
################################################################################


################################################################################
# Pre-conditions
# > $FLERE_IMSAHO/data/audio/tracks SHOULD NOT be empty.
#     i.e. tracks have been placed there to be processed.
#
# Post-conditions
# > $FLERE_IMSAHO/data/audio/clips
#   All the generated clips will be here.
#   Some are not desired and can be deleted with the delete-clips.sh script.
#   But leaving them there shouldn't hurt anyway because they will not be
#   included in the flere-imsaho.csv file.
#   This file identifies which clips are to be fed into the machine learning
#   data set.
################################################################################

if [ -z "$(ls -A $FLERE_IMSAHO/data/audio/tracks)" ]
then
  echo "tracks directory is empty"
  exit;
fi;

numberOfNewClipsBefore=$(ls -l $FLERE_IMSAHO/data/audio/new-clips | grep '^-.*mp3' | wc -l)

################################################################################
# Convert all m4a files to mp3 files. Delete the m4a files.
################################################################################

echo 'commence m4a file eradication ...'

cd $FLERE_IMSAHO/data/audio/tracks

SAVEIF=$IFS
IFS=$(echo -en "\n\b")

for file in $(ls *m4a)
do
  name=${file%%.m4a}
  ffmpeg -i ${name}.m4a ${name}.mp3
done

IFS=$SAVEIFS


###############################################################################
# Extract multiple short clips
# These clips must be long enough that a human can listen to and
# judge its intensity or valence relative to another snippet
################################################################################

echo 'generating new audio clips ...'
cd $FLERE_IMSAHO/data/audio/tracks

SAVEIF=$IFS
IFS=$(echo -en "\n\b")

for file in $(ls *mp3)
do
  name=${file%%.mp3}
  sox ${name}.mp3 ../clips/${name}.30.mp3 trim 30 2
  sox ${name}.mp3 ../clips/${name}.40.mp3 trim 40 2
  sox ${name}.mp3 ../clips/${name}.50.mp3 trim 50 2
  sox ${name}.mp3 ../clips/${name}.60.mp3 trim 60 2
  sox ${name}.mp3 ../clips/${name}.70.mp3 trim 70 2
  sox ${name}.mp3 ../clips/${name}.80.mp3 trim 80 2
done

IFS=$SAVEIFS


################################################################################
# echo stats
################################################################################

numberOfNewClipsAfter=$(ls -l $FLERE_IMSAHO/data/audio/new-clips | grep '^-.*mp3' | wc -l)
echo "numberOfNewClipsBefore = $numberOfNewClipsBefore"
echo "numberOfNewClipsAfter = $numberOfNewClipsAfter"


