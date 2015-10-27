#!/bin/bash

################################################################################
# Pre-reqs
#   We need to know how to connect to the database
#   Hostname and port are specified in environment variables
#   Username and password are specified in ~/.my.cnf
################################################################################

if [ -z $DB_HOST ]; then
    printf "DB_HOST environment variable not defined!\n"
    exit 0;
fi
if [ -z $DB_PORT ]; then
    printf "DB_PORT environment variable not defined!\n"
    exit 0;
fi




################################################################################
# The data comes from these CSV files
################################################################################
FILE1=$FLERE_IMSAHO/data/playlists/output/training-set-predictions-with-indices.csv
FILE2=$FLERE_IMSAHO/data/playlists/output/validation-set-predictions-with-indices.csv
FILE3=$FLERE_IMSAHO/data/playlists/output/test-set-predictions-with-indices.csv

if [ ! -f $FILE1 ]; then
    printf "File does not exist: %s\n" "$FILE1"
    exit 0;
fi

if [ ! -f $FILE2 ]; then
    printf "File does not exist: %s\n" "$FILE2"
    exit 0;
fi

if [ ! -f $FILE3 ]; then
    printf "File does not exist: %s\n" "$FILE3"
    exit 0;
fi

################################################################################
# Squeeze 'em together into this file
################################################################################
GINORMOUS=$FLERE_IMSAHO/data/mysql/load.csv

################################################################################
# Clean the ginormous file to create this file
# This is the file that we load directly into the table
################################################################################
CLEAN=$FLERE_IMSAHO/data/mysql/clean.csv


cp $FILE1 $GINORMOUS
ls -lF $GINORMOUS

cat $FILE2 | tail -n +2 $FILE2 >> $GINORMOUS
ls -lF $GINORMOUS

cat $FILE3 | tail -n +2 $FILE >> $GINORMOUS
ls -lF $GINORMOUS

################################################################################
# Let's be sure that we have as many records that we think we should have
################################################################################

FILE1_LINE_COUNT=$(wc -l $FILE1 | cut -d' ' -f1)
FILE2_LINE_COUNT=$(wc -l $FILE2 | cut -d' ' -f1)
FILE3_LINE_COUNT=$(wc -l $FILE3 | cut -d' ' -f1)

EXPECTED_LINE_COUNT=$(($FILE1_LINE_COUNT + $FILE2_LINE_COUNT + $FILE3_LINE_COUNT -2))
ACTUAL_LINE_COUNT=$(wc -l $GINORMOUS | cut -d' ' -f1)

printf "EXPECTED_LINE_COUNT: %d\n" "$EXPECTED_LINE_COUNT"
printf "  ACTUAL_LINE_COUNT: %d\n" "$ACTUAL_LINE_COUNT"

sed 's/"//g' $GINORMOUS > $CLEAN

head $CLEAN

################################################################################
# Finally, load the data into the table
################################################################################

mysql -h $DB_HOST -P $DB_PORT music < $FLERE_IMSAHO/data/mysql/load.sql

