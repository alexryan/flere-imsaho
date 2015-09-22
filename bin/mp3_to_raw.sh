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

cd $FLERE_IMSAHO/data/audio/new-clips

SAVEIF=$IFS
IFS=$(echo -en "\n\b")

# -bash: /usr/local/opt/coreutils/libexec/gnubin/ls: Argument list too long
#
#for file in $(ls *mp3)
#do
#  name=${file%%.mp3}
#  sox ${name}.mp3 -c 1 -r 4000 --bits 16 ${name}.mono-sr4000-ss16.raw
#done



# Move new-clips to the clips folder
#FILES=$FLERE_IMSAHO/data/audio/new-clips/*.mp3
#for file in $FILES
#do
#  mv ${file} $FLERE_IMSAHO/data/audio/clips
#done

# Remove the old raw files in the new-clips folder
#FILES=$FLERE_IMSAHO/data/audio/new-clips/*-sr4000-ss16.raw
#for file in $FILES
#do
#  rm ${file}
#done

# Remove all the raw files in the "clips" folder
#FILES=$FLERE_IMSAHO/data/audio/clips/*-sr1000-ss16.raw
#for file in $FILES
#do
#  rm ${file}
#done

# Convert MP3 clips to RAW clips using a 1000Hz sampling rate
#FILES=$FLERE_IMSAHO/data/audio/clips/*.mp3
#for file in $FILES
#do
#  name=${file%%.mp3}
#  sox ${name}.mp3 -c 1 -r 500 --bits 16 ${name}.mono-sr0500-ss16.raw
#done

IFS=$SAVEIFS


################################################################################
# Delete any clips that are not FULL clips.
################################################################################

#find -name "$FLERE_IMSAHO/data/audio/new-clips*.raw" -size -16092c -delete


################################################################################
# echo stats
################################################################################

numberOfFullSongs=$(ls -l $FLERE_IMSAHO/data/audio/tracks | grep '^-.*mp3' | wc -l)
numberOfClips=$(ls -l $FLERE_IMSAHO/data/audio/new-clips | grep '^-.*.raw' | wc -l)
echo "numberOfFullSongs = $numberOfFullSongs"
echo "numberOfClips = $numberOfClips"

# Do we have ALL of the audio files listed in the CSV?
numberOfSongsInCsv=$(wc -l $FLERE_IMSAHO/data/audio/flere-imsaho.csv)
echo "numberOfSongsInCsv = $numberOfSongsInCsv"



