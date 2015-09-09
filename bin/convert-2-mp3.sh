#!/bin/bash

################################################################################
# Convert M4A files to MP3 files in this directory.
# $FLERE_IMSAHO/data/audio/new-tracks
# Check the stats at the end to make sure that all files have been converted.
# When this is verified, you might choose to manually delete the source files.
#
################################################################################

if [ -z "$(ls -A $FLERE_IMSAHO/data/audio/new-tracks)" ]
then
  echo "new-tracks directory is empty"
  exit;
fi;

numberOfMP3sBefore=$(ls -l $FLERE_IMSAHO/data/audio/new-tracks | grep '^-.*mp3' | wc -l)
numberOfM4As=$(ls -l $FLERE_IMSAHO/data/audio/new-tracks | grep '^-.*m4a' | wc -l)

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
  ffmpeg -n -i ${name}.m4a ${name}.mp3
done

IFS=$SAVEIFS


################################################################################
# echo stats
################################################################################

numberOfMP3sAfter=$(ls -l $FLERE_IMSAHO/data/audio/new-tracks | grep '^-.*mp3' | wc -l)
numberOfNewMP3s=`expr $numberOfMP3sAfter - $numberOfMP3sBefore`

echo "numberOfMP3sBefore = $numberOfMP3sBefore"
echo "numberOfMP3sAfter  = $numberOfMP3sAfter"
echo "numberOfNewMP3s    = $numberOfNewMP3s"
echo "numberOfM4As       = $numberOfM4As"

