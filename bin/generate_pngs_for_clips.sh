#!/bin/bash

mp3Dir=$FLERE_IMSAHO/data/audio/clips
pngDir=$FLERE_IMSAHO/data/audio/clips-images

listOfMP3sFile=/tmp/mp3s.dat
listOfPNGsFile=/tmp/pngs.dat
listOfPNGsToGenerateFile=/tmp/new-pngs.dat
listOfMysteryPNGs=/tmp/mystery-pngs.dat


rm $listOfMP3sFile 2> /dev/null
rm $listOfPNGsFile 2> /dev/null

################################################################################
# Create a sorted list of our audio files
################################################################################
cd $mp3Dir
ls -A1 $mp3Dir | grep ".*.mp3$" | sed 's/....$//' > $listOfMP3sFile
sort $listOfMP3sFile -o $listOfMP3sFile

################################################################################
# Create a sorted list of our image files
################################################################################
cd $png3Dir
ls -A1 $pngDir | grep ".*.png$" | sed 's/....$//' > $listOfPNGsFile
sort $listOfPNGsFile -o $listOfPNGsFile

################################################################################
# Get the list of audio files which do not yet have corresponding image files
################################################################################
comm -23 $listOfMP3sFile $listOfPNGsFile > $listOfPNGsToGenerateFile

comm -13 $listOfMP3sFile $listOfPNGsFile > $listOfMysteryPNGs


################################################################################
# Due Diligence: Did we miss any?
################################################################################
numberOfMP3Files=$(wc -l $listOfMP3sFile | cut -d' ' -f1)
numberOfPNGFiles=$(wc -l $listOfPNGsFile | cut -d' ' -f1)
numberOfPNGsToGenerate=$(wc -l $listOfPNGsToGenerateFile | cut -d' ' -f1)
expected=$(($numberOfMP3Files - $numberOfPNGFiles))

printf "numberOfMP3Files:                  %d\n" "$numberOfMP3Files"
printf "numberOfPNGFiles:                  %d\n" "$numberOfPNGFiles"
printf "numberOfPNGsToGenerate (expected): %d\n" "$expected"
printf "numberOfPNGsToGenerate (actual):   %d\n" "$numberOfPNGsToGenerate"

#head $listOfMP3sFile
#head $listOfPNGsFile
