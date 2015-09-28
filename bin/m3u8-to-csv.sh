#!/bin/bash

################################################################################
# The .m3u8 file contains a sorted playlist.
# https://en.wikipedia.org/?title=M3U
# Extract just the filenames from this playlist
################################################################################

if [ "$#" -ne 1 ]; then
  echo "Usage: m3u8-to-csv infile.m3u8"
  exit
fi

infile=$1
extension="${infile##*.}"
if [ "$extension" != "m3u8" ]; then
  echo "infile must have the m3u8 extension"
fi

################################################################################
# generated csv file will have the same name as the input file but a different extension
# Example:
#   infile=experiment.m3u8
#   outfile=experiment.csv
################################################################################
basename="${infile%.*}"
outfile=$basename.csv

#echo "basename:$basename"
echo "outfile:$outfile"

# Use REAL newline characters so that unix tools like sed can process the file
tr '\r' '\n' < $infile > temp1.dat

# Remove everything on the line other than the filename
cat temp1.dat | sed s:.*/:: > temp2.dat

# Remove the .mp3 extension
cat temp2.dat | sed s/\.mp3// > temp3.dat

# Remove the lines that start with #EXT
cat temp3.dat | sed s/^#EXT.*// > temp4.dat

# Remove all the extra empty lines
sed  '/^$/d' temp4.dat > $outfile

# Clean up temporary files
rm temp*.dat

