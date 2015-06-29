#!/bin/bash

################################################################################
# Take multiple 2 second audio clips from every MP3 file in
# $FLERE_IMSAHO/data/audio/full
# and place it them in
# $FLERE_IMSAHO/data/audio/snippets
# as .raw files.
################################################################################

################################################################################
# Convert all m4a files to mp3 files. Delete the m4a files.
################################################################################

echo 'commence m4a file eradication ...'

cd $FLERE_IMSAHO/data/audio/full

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

echo 'deleting old audio clips ...'
rm $FLERE_IMSAHO/data/audio/snippets/*

echo 'generating new audio clips ...'
cd $FLERE_IMSAHO/data/audio/full

SAVEIF=$IFS
IFS=$(echo -en "\n\b")

for file in $(ls *mp3)
do
  name=${file%%.mp3}
  sox ${name}.mp3 ../snippets/${name}.30.mp3 trim 30 2
  sox ${name}.mp3 ../snippets/${name}.40.mp3 trim 40 2
  sox ${name}.mp3 ../snippets/${name}.50.mp3 trim 50 2
  sox ${name}.mp3 ../snippets/${name}.60.mp3 trim 60 2
  sox ${name}.mp3 ../snippets/${name}.70.mp3 trim 70 2
  sox ${name}.mp3 ../snippets/${name}.80.mp3 trim 80 2
done

IFS=$SAVEIFS


################################################################################
# Convert all mp3 files to raw format.
#   $FLERE_IMSAHO/data/audio/full/${name}.mono-sr-4000-ss8.raw
################################################################################

echo 'u want it raw? ...'

cd $FLERE_IMSAHO/data/audio/snippets

SAVEIF=$IFS
IFS=$(echo -en "\n\b")

for file in $(ls *mp3)
do
  name=${file%%.mp3}
  sox ${name}.mp3 -c 1 -r 4000 --bits 16 ${name}.mono-sr4000-ss16.raw
done

IFS=$SAVEIFS


################################################################################
# echo stats
################################################################################

numberOfFullSongs=$(ls -l $FLERE_IMSAHO/data/audio/full | grep '^-.*.mp3' | wc -l)
numberOfClips=$(ls -l $FLERE_IMSAHO/data/audio/snippets | grep '^-.*.raw' | wc -l)
echo "numberOfFullSongs = $numberOfFullSongs"
echo "numberOfClips = $numberOfClips"



