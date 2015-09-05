#!/bin/sh

################################################################################
# Generate $FLERE_IMSAHO/data/audio/experiment.csv
################################################################################

cd $FLERE_IMSAHO/data/audio
m3u8-to-csv.sh flere-imsaho_0.m3u8
m3u8-to-csv.sh flere-imsaho_1.m3u8
sed 's/$/,0/' flere-imsaho_0.csv > flere-imsaho_0.csv.new
sed 's/$/,1/' flere-imsaho_1.csv > flere-imsaho_1.csv.new
cat flere-imsaho_0.csv.new flere-imsaho_1.csv.new > flere-imsaho.csv
ls -lF flere-imsaho*.*

