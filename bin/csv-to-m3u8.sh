#!/bin/bash

################################################################################
# The .csv file contains a sorted list of audio clips
# Each record contains the full name of the clip plus a bunch of other info.
# This sccript extracts only the name of the clip from this file
# and generates an .m3u8 file that can be imported into iTunes as a playlist.
# Note: This script assumes that the audio clip is alread in iTunes
# and is stored in the correct location.
# This is important because we don't want the same clips to be reimported into
# iTunes over and over again.
# Extract just the filenames from this playlist
# CSV file format examples:
#   https://github.com/alexryan/flere-imsaho/tree/master/data/matlab
# M3U8 file format examples:
#   https://github.com/alexryan/flere-imsaho/tree/master/data/audio
# M3U8 file format:
#   https://en.wikipedia.org/wiki/M3U
################################################################################

if [ "$#" -ne 1 ]; then
    echo "Usage: csv-to-mu38 infile.csv"
    exit
fi

infile=$1
extension="${infile##*.}"
if [ "$extension" != "csv" ]; then
    echo "infile must have the csv extension"
fi

################################################################################
# generated m3u8 file will have the same name as the input file but a different extension
# Example:
#   infile=experiment.csv
#   outfile=experiment.m3u8
################################################################################
basename="${infile%.*}"
outfile=$basename.m3u8

#echo "basename:$basename"
echo "outfile:$outfile"

header="#EXTM3U"
startingToken="#EXTINF:2,"
pathToAllClips="/Users/alexryan/Music/iTunes/iTunes Media/Music/Unknown Artist/Unknown Album/"

# Remove the header
echo "$(tail -n +2 $infile)" > $infile

cat $infile | cut -d ',' -f1 > clipNamesOnly.dat

#sed 's/^.*/i ${startingToken}/' clipNamesOnly.dat > temp1.dat 

rm temp1.dat 2> /dev/null
cat clipNamesOnly.dat | while read line; do
  printf  "${startingToken}${line} - \n${pathToAllClips}${line}.mp3\n" >> temp1.dat
done
    
sed "1i ${header}" temp1.dat > $outfile

# Clean up temporary files
rm clipNamesOnly.dat
rm temp1.dat
