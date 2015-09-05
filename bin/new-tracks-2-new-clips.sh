#!/bin/bash

################################################################################
# Take multiple audio clips from every MP3 file in
# $FLERE_IMSAHO/data/audio/new-tracks
# and place it them in
# $FLERE_IMSAHO/data/audio/new-clips
# as .raw files.
################################################################################


################################################################################
# Pre-conditions
# > $FLERE_IMSAHO/data/audio/new-tracks SHOULD NOT be empty.
#     i.e. new tracks have been placed there to be processed.
# > $FLERE_IMSAHO/data/audio/new-clips SHOULD be empty.
#     i.e. Dumping new clips to a mix of existing clips makes it more difficult
#     to find the new clips.
#     After new clips are generated, they should be manually processed.
#     The survivors should be moved
#     $FLERE_IMSAHO/data/audio/clips.
#     After this manual processing the "new-clips" directory should be empty.
################################################################################

#[ "$(ls -A $FLERE_IMSAHO/data/audio/new-clips)" ] && echo "Not Empty" || echo "Empty"
#exit 1;

if [ -z "$(ls -A $FLERE_IMSAHO/data/audio/new-tracks)" ]
then
  echo "new-tracks directory is empty"
  exit;
fi;

numberOfNewClipsBefore=$(ls -l $FLERE_IMSAHO/data/audio/new-clips | grep '^-.*mp3' | wc -l)

################################################################################
# Convert all m4a files to mp3 files. Delete the m4a files.
################################################################################

echo 'commence m4a file eradication ...'

cd $FLERE_IMSAHO/data/audio/new-tracks

SAVEIF=$IFS
IFS=$(echo -en "\n\b")

for file in $(ls *m4a)
do
  name=${file%%.m4a}
  ffmpeg -i ${name}.m4a ${name}.mp3
done

IFS=$SAVEIFS


###############################################################################
# Extract multiple short snippets from each raw file
# These snippets must be long enough that a human can listen to and
# judge its intensity or valence relative to another snippet
################################################################################

#echo 'deleting old audio clips ...'
#rm $FLERE_IMSAHO/data/audio/snippets/*

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


