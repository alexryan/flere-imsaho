#!/bin/sh

export MP3_DIR="$FLERE_IMSAHO/data/audio/clips"
export PNG_DIR="$FLERE_IMSAHO/data/audio/clips-images"
export NEW_PNG_LIST="/tmp/new-pngs.dat"
export MATLAB_TEMP_FILE="$FLERE_IMSAHO/data/matlab/flere-imsaho-temp.mat"

octave $FLERE_IMSAHO/src/generate_plots_for_N_specified_clips.m

