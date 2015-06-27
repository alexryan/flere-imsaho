#!/bin/sh

################################################################################
# Generate $ALPINE_GIT/machineLearning/data/audio/experiment.csv
################################################################################

cd $ALPINE_GIT/machineLearning/data/audio
m3u8-to-csv.sh experiment.m3u8

