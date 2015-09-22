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

clipDir=$FLERE_IMSAHO/data/audio/new-clips

echo "Converting MP3 files to RAW files in this directory: $clipDir"
read -n1 -r -p "Press any key to continue..." key

numberOfRawClipsBefore=$(ls -l $clipDir | grep '^-.*.raw' | wc -l)

SAVEIF=$IFS
IFS=$(echo -en "\n\b")

# Convert MP3 clips to RAW clips using a 500Hz sampling rate

start=`date +%s`

FILES=$clipDir/*.mp3
for file in $FILES
do
  name=${file%%.mp3}
  sox ${name}.mp3 -c 1 -r 500 --bits 16 ${name}.mono-sr0500-ss16.raw
done

end=`date +%s`
runtime=$((end-start))

IFS=$SAVEIFS


################################################################################
# Delete any clips that are not FULL clips.
################################################################################

#find -name "$FLERE_IMSAHO/data/audio/new-clips*.raw" -size -16092c -delete


################################################################################
# echo stats
################################################################################
numberOfRawClipsAfter=$(ls -l $clipDir | grep '^-.*.raw' | wc -l)

echo "               runtime = $runtime"
echo "numberOfRawClipsBefore = $numberOfRawClipsBefore"
echo "numberOfRawClipsAfter  = $numberOfRawClipsAfter"



