#!/bin/bash



################################################################################
# Convert all m4a files to mp3 files. Delete the m4a files.
################################################################################

################################################################################
# Convert all mp3 files to raw format.
#   $ALPINE_GIT/machineLearning/data/audio/full/${name}.mono-sr-4000-ss8.raw
################################################################################

if false; then
cd $ALPINE_GIT/machineLearning/data/audio/full

SAVEIF=$IFS
IFS=$(echo -en "\n\b")

for file in $(ls *mp3)
do
  name=${file%%.mp3}
  sox ${name}.mp3 -c 1 -r 4000 --bits 8 ${name}.mono-sr4000-ss8.raw
done

IFS=$SAVEIFS
fi

################################################################################
# Extract multiple short snippets from each raw file
# These snippets must be long enough that a human can listen to and
# judge its intensity or valence relative to another snippet
################################################################################

cd $ALPINE_GIT/machineLearning/data/audio/full

SAVEIF=$IFS
IFS=$(echo -en "\n\b")

for file in $(ls *mp3)
do
  name=${file%%.mp3}
  sox ${name}.mp3 ../snippets/${name}.3me=${file%%.mp3}0.mp3 trim 30 2
  sox ${name}.mp3 ../snippets/${name}.40.mp3 trim 40 2
  sox ${name}.mp3 ../snippets/${name}.50.mp3 trim 50 2
  sox ${name}.mp3 ../snippets/${name}.60.mp3 trim 60 2
  sox ${name}.mp3 ../snippets/${name}.70.mp3 trim 70 2
  sox ${name}.mp3 ../snippets/${name}.80.mp3 trim 80 2
done

IFS=$SAVEIFS



################################################################################
# load all of these snippets into an iTunes playlist
# where a human will manually order them from low to high intensity
################################################################################


################################################################################
# extract the manually sorted iTunes playlist
# generate I-numbers from 0 to 1 for all the songs in the training set.
################################################################################


################################################################################
# randomly separate the data into training and test data
# $ALPINE_GIT/machineLearning/sound/training
# $ALPINE_GIT/machineLearning/sound/test
################################################################################


################################################################################
# load all the data into octave
# the raw data for the song snippets go into da matrix
# the I-number labels go into da vector
################################################################################


################################################################################
# invoke da magical machine learning algorithm to give birth to a magical classifier
################################################################################


################################################################################
# now we can use da magical classifier to make prediction on test data. :)
################################################################################


