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
  sox ${name}.mp3 ../new-clips/${name}.000.mp3 trim 0 2
  sox ${name}.mp3 ../new-clips/${name}.002.mp3 trim 2 2
  sox ${name}.mp3 ../new-clips/${name}.004.mp3 trim 4 2
  sox ${name}.mp3 ../new-clips/${name}.006.mp3 trim 6 2
  sox ${name}.mp3 ../new-clips/${name}.008.mp3 trim 8 2
  sox ${name}.mp3 ../new-clips/${name}.010.mp3 trim 10 2

  sox ${name}.mp3 ../new-clips/${name}.012.mp3 trim 12 2
  sox ${name}.mp3 ../new-clips/${name}.014.mp3 trim 14 2
  sox ${name}.mp3 ../new-clips/${name}.016.mp3 trim 16 2
  sox ${name}.mp3 ../new-clips/${name}.018.mp3 trim 18 2
  sox ${name}.mp3 ../new-clips/${name}.020.mp3 trim 20 2

  sox ${name}.mp3 ../new-clips/${name}.022.mp3 trim 22 2
  sox ${name}.mp3 ../new-clips/${name}.024.mp3 trim 24 2
  sox ${name}.mp3 ../new-clips/${name}.026.mp3 trim 26 2
  sox ${name}.mp3 ../new-clips/${name}.028.mp3 trim 28 2
  sox ${name}.mp3 ../new-clips/${name}.030.mp3 trim 30 2
  
  sox ${name}.mp3 ../new-clips/${name}.032.mp3 trim 32 2
  sox ${name}.mp3 ../new-clips/${name}.034.mp3 trim 34 2
  sox ${name}.mp3 ../new-clips/${name}.036.mp3 trim 36 2
  sox ${name}.mp3 ../new-clips/${name}.038.mp3 trim 38 2
  
  sox ${name}.mp3 ../new-clips/${name}.040.mp3 trim 40 2
  sox ${name}.mp3 ../new-clips/${name}.042.mp3 trim 42 2
  sox ${name}.mp3 ../new-clips/${name}.044.mp3 trim 44 2
  sox ${name}.mp3 ../new-clips/${name}.046.mp3 trim 46 2
  sox ${name}.mp3 ../new-clips/${name}.048.mp3 trim 48 2
  sox ${name}.mp3 ../new-clips/${name}.050.mp3 trim 50 2
  
  sox ${name}.mp3 ../new-clips/${name}.052.mp3 trim 52 2
  sox ${name}.mp3 ../new-clips/${name}.054.mp3 trim 54 2
  sox ${name}.mp3 ../new-clips/${name}.056.mp3 trim 56 2
  sox ${name}.mp3 ../new-clips/${name}.058.mp3 trim 58 2
  sox ${name}.mp3 ../new-clips/${name}.060.mp3 trim 60 2
  
  sox ${name}.mp3 ../new-clips/${name}.062.mp3 trim 62 2
  sox ${name}.mp3 ../new-clips/${name}.064.mp3 trim 64 2
  sox ${name}.mp3 ../new-clips/${name}.066.mp3 trim 66 2
  sox ${name}.mp3 ../new-clips/${name}.068.mp3 trim 68 2
  sox ${name}.mp3 ../new-clips/${name}.070.mp3 trim 70 2

done

IFS=$SAVEIFS


################################################################################
# echo stats
################################################################################

numberOfNewClipsAfter=$(ls -l $FLERE_IMSAHO/data/audio/new-clips | grep '^-.*mp3' | wc -l)
echo "numberOfNewClipsBefore = $numberOfNewClipsBefore"
echo "numberOfNewClipsAfter = $numberOfNewClipsAfter"


