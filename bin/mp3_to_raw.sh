#!/bin/bash

################################################################################
# Conert all mp3 files to raw format.
#
# Convert each 2 second mp3 audio clip from every MP3 clip in the "clips" directory:
# $FLERE_IMSAHO/data/audio/clips
#
# Example:
#
# SOURCE: The_Piano_Guys-A_Thousand_Years.30.mp3
# ... gets converted to ...
# TARGET: The_Piano_Guys-A_Thousand_Years.30.mono-sr4000-ss16.raw
#
# Meaning ofthe filename?
#
# mono   => left and right channels are compbined into a single channel
# sr4000 => sampling rate = 4000 samples per second
# ss16   => sample size = 16 bits
#
################################################################################

echo 'u want it raw? ...'

numberOfRAWClipsBefore=$(ls -l $clipDir | grep '^-.*.raw' | wc -l)
numberOfMP3ClipsBefore=$(ls -l $clipDir | grep '^-.*.mp3' | wc -l)

cd $FLERE_IMSAHO/data/audio/new-clips

SAVEIF=$IFS
IFS=$(echo -en "\n\b")


# Convert MP3 clips to RAW clips using a 1000Hz sampling rate
FILES=$FLERE_IMSAHO/data/audio/clips/*.mp3
for file in $FILES
do
  name=${file%%.mp3}
  sox ${name}.mp3 -c 1 -r 500 --bits 16 ${name}.mono-sr0500-ss16.raw
done

IFS=$SAVEIFS


################################################################################
# echo stats
################################################################################

numberOfRAWClipsAfter=$(ls -l $clipDir | grep '^-.*.raw' | wc -l)
numberOfMP3ClipsAfter=$(ls -l $clipDir | grep '^-.*.mp3' | wc -l)

echo "numberOfRAWFilesBefore = $numberOfRAWFilesBefore"
echo "numberOfRAWFilesAfter  = $numberOfRAWFilesAfter"
echo "numberOfMP3FilesBefore = $numberOfMP3FilesBefore"
echo "numberOfMP3FilesAfter  = $numberOfMP3FilesAfter"

