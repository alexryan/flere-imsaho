#!/bin/bash

################################################################################
# Take multiple audio clips from every MP3 file in
# $FLERE_IMSAHO/data/audio/new-tracks
# and place it them in
# $FLERE_IMSAHO/data/audio/new-clips
#
# The format of the track is MP3.
# The format of the clips is MP3.
# Only after the clips have been processed by a human and assigned the appropriate
# label will we convert them to RAW format for use with machine learning.
#
# Clips  must be long enough that a human can listen to and
# discern its intensity or valence relative to another clip.
#
# Pre-conditions
# > $FLERE_IMSAHO/data/audio/new-tracks SHOULD NOT be empty.
#     i.e. new tracks have been placed there to be processed.
# > All new-tracks that you want to extract clips from must have already been
#   converted to MP3s.
# > $FLERE_IMSAHO/data/audio/new-clips SHOULD be empty.
#     i.e. Dumping new clips to a mix of existing clips makes it more difficult
#     to find the new clips.
#     If it is not empty, the stats re the number of new clips generated will be
#     incorrect.
# Next steps:
# > A human must manually process these clips in iTunes.
#   Delete the ones that are not usable.
#   Assign a label to those that are (by placing then in the appropriate playlist).
#   The clipse that survive the process should be moved here:
#     $FLERE_IMSAHO/data/audio/clips.
#
################################################################################

if [ -z "$(ls -A $FLERE_IMSAHO/data/audio/new-tracks)" ]
then
  echo "new-tracks directory is empty"
  exit;
fi;

numberOfNewClipsBefore=$(ls -l $FLERE_IMSAHO/data/audio/new-clips | grep '^-.*mp3' | wc -l)

echo 'generating new audio clips ...'
cd $FLERE_IMSAHO/data/audio/new-tracks

SAVEIF=$IFS
IFS=$(echo -en "\n\b")

for file in $(ls *mp3)
do
  name=${file%%.mp3}
  sox ${name}.mp3 ../new-clips/${name}.30.mp3 trim 30 2
  sox ${name}.mp3 ../new-clips/${name}.40.mp3 trim 40 2
  sox ${name}.mp3 ../new-clips/${name}.50.mp3 trim 50 2
  sox ${name}.mp3 ../new-clips/${name}.60.mp3 trim 60 2
  sox ${name}.mp3 ../new-clips/${name}.70.mp3 trim 70 2
  sox ${name}.mp3 ../new-clips/${name}.80.mp3 trim 80 2
done

IFS=$SAVEIFS


################################################################################
# echo stats
################################################################################

numberOfNewClipsAfter=$(ls -l $FLERE_IMSAHO/data/audio/new-clips | grep '^-.*mp3' | wc -l)
echo "numberOfNewClipsBefore = $numberOfNewClipsBefore"
echo "numberOfNewClipsAfter = $numberOfNewClipsAfter"


