#!/bin/sh

OCTAVE_PATH=$FLERE_IMSAHO/src

cd $OCTAVE_PATH

octave --path $OCTAVE_PATH $FLERE_IMSAHO/src/generate_data_sets.m

