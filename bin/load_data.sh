#!/bin/bash

FILE1=$FLERE_IMSAHO/data/playlists/output/training-set-predictions-with-indices.csv
FILE2=$FLERE_IMSAHO/data/playlists/output/validation-set-predictions-with-indices.csv
FILE3=$FLERE_IMSAHO/data/playlists/output/test-set-predictions-with-indices.csv
GINORMOUS=$FLERE_IMSAHO/data/mysql/load.csv
CLEAN=$FLERE_IMSAHO/data/mysql/clean.csv


cp $FILE1 $GINORMOUS
ls -lF $GINORMOUS

cat $FILE2 | tail -n +2 $FILE2 >> $GINORMOUS
ls -lF $GINORMOUS

cat $FILE3 | tail -n +2 $FILE >> $GINORMOUS
ls -lF $GINORMOUS

FILE1_LINE_COUNT=$(wc -l $FILE1 | cut -d' ' -f1)
FILE2_LINE_COUNT=$(wc -l $FILE2 | cut -d' ' -f1)
FILE3_LINE_COUNT=$(wc -l $FILE3 | cut -d' ' -f1)

EXPECTED_LINE_COUNT=$(($FILE1_LINE_COUNT + $FILE2_LINE_COUNT + $FILE3_LINE_COUNT -2))
ACTUAL_LINE_COUNT=$(wc -l $GINORMOUS | cut -d' ' -f1)

printf "EXPECTED_LINE_COUNT: %d\n" "$EXPECTED_LINE_COUNT"
printf "  ACTUAL_LINE_COUNT: %d\n" "$ACTUAL_LINE_COUNT"

sed 's/"//g' $GINORMOUS > $CLEAN

head $CLEAN

mysql music < $FLERE_IMSAHO/data/mysql/load.sql

