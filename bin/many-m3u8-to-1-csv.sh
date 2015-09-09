#!/bin/sh

################################################################################
# Generate $FLERE_IMSAHO/data/audio/experiment.csv
################################################################################

cd $FLERE_IMSAHO/data/audio
m3u8-to-csv.sh flere-imsaho_1.m3u8
m3u8-to-csv.sh flere-imsaho_2.m3u8
sed 's/$/,1/' flere-imsaho_1.csv > flere-imsaho_1.csv.new
sed 's/$/,2/' flere-imsaho_2.csv > flere-imsaho_2.csv.new
cat flere-imsaho_1.csv.new flere-imsaho_2.csv.new > flere-imsaho.csv
ls -lF flere-imsaho*.*

