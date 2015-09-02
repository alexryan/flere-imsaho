#!/bin/sh

################################################################################
# Generate $FLERE_IMSAHO/data/audio/experiment.csv
################################################################################

cd $FLERE_IMSAHO/data/audio
m3u8-to-csv.sh experiment.m3u8

