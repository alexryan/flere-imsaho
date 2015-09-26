#!/bin/sh

OCTAVE_PATH=$FLERE_IMSAHO/src
#cd $OCTAVE_PATH
octave --path $OCTAVE_PATH $FLERE_IMSAHO/src/generate_prediction_data.m

#octave $FLERE_IMSAHO/src/generate_prediction_data.m
cd $FLERE_IMSAHO/data/matlab

csvjoin training-set.csv training-set-predictions.csv > magic.csv
rm training-set-predictions.csv
mv magic.csv training-set-predictions.csv

csvjoin validation-set.csv validation-set-predictions.csv > magic.csv
rm validation-set-predictions.csv
mv magic.csv validation-set-predictions.csv

csvjoin test-set.csv test-set-predictions.csv > magic.csv
rm test-set-predictions.csv
mv magic.csv test-set-predictions.csv


