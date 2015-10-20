#!/bin/bash

################################################################################
# This script is meant to be called from a servlet
# imediately after the servlet has deposited an MP3 file onto the file system
# for processing.
# The purpose of this script is to generate the intesity profile of the song.
# We chop the song up into 2 second segments
# run each through the neural net to out the intensity prediction for each
# then write the complete series of predictions to a file.
# Currently, our neural net can only predict low and high intensities.
# So the output file will contain a series of 1's and 2's.
#
# Pre-requisites:
#   The following environment variables must be set:
#
# MP3_DIR:
#   Directory containing the MP3 file to be processed.
#   A RAW file will be generated here by this script.
# MP3_FILE
#   The name of the MP3 file that gets written to the directory by the servlet.
# RAW_FILE
#   The name of the RAW file that we will generate from the MP3 file using sox.
# PNG_DIR
#   The directory to which this script should write the PNG file.
# PNG_FILE
#   The name of the PNG file that will will generate from the RAW file using octave.
# FLERE_IMSAHO
#   The home directory of the FLERE_IMSAHO project on this machine
# PATH
#   Must contain access to all of the executables needed to run this script:
#   sox, octave, fig2dev, etc.
# WEIGHTS
#   The magical matlab file containing a set of weights (matrices) for the
#   neural net to prcess and make predictions.
#
# The following software must be installed and available in the PATH:
#   sox
#   octave
#   mysql
#
# The process owner running this script must have database credentials
# in ~/.my.cnf
#
################################################################################

# Check that environment variables have been properly set
#set

if [ -z "$FLERE_IMSAHO" ]; then
  printf "FLERE_IMSAHO environment variable is not set.\n"
  exit 0
fi
#printf"FLERE_IMSAHO=$FLERE_IMSAHO\n"

if [ -z "$MP3_DIR" ]; then
  printf "MP3_DIR environment variable is not set.\n"
  exit 0
fi

if [ -z "$MP3_FILE" ]; then
  printf "MP3_FILE environment variable is not set.\n"
  exit 0
fi

if [ -z "$RAW_FILE" ]; then
  printf "RAW_FILE environment variable is not set.\n"
  exit 0
fi

if [ -z "$PNG_DIR" ]; then
  printf "PNG_DIR environment variable is not set.\n"
  exit 0
fi

if [ -z "$PNG_FILE" ]; then
  printf "PNG_FILE environment variable is not set.\n"
  exit 0
fi

if [ -z "$WEIGHTS" ]; then
  printf "WEIGHTS environment variable is not set.\n"
  exit 0
fi

if [ -z "$DB_HOST" ]; then
  printf "DB_HOST environment variable is not set.\n"
  exit 0
fi


if ! type sox > /dev/null; then
  printf "sox is not accessible in PATH\n
  exit 0
fi

if ! type octave > /dev/null; then
  printf "octave is not accessible in PATH\n
  exit 0
fi

###############################################################################
# Extract multiple short clips
# These clips must be long enough that a human can listen to and
# judge its intensity or valence relative to another snippet
################################################################################

echo 'converting mp3 to raw ...'
cd $MP3_DIR

STARTTIME=$(date +%s)
sox $MP3_FILE --channels 1 -r 500 --bits 16 $RAW_FILE
ENDTIME=$(date +%s)
time2GenerateRawFile="$(($ENDTIME - $STARTTIME))"
							 
echo "generated file ..."
ls -lF $RAW_FILE

################################################################################
# Convert the generated RAW file to a series of predictions
################################################################################
OCTAVE_PATH=$FLERE_IMSAHO/src

echo "running the octave script ..."

STARTTIME=$(date +%s)
octave $FLERE_IMSAHO/src/process_full_mp3.m
ENDTIME=$(date +%s)
time2RunOctave="$(($ENDTIME - $STARTTIME))"


################################################################################
# Persist the data to a relational database
################################################################################
STARTTIME=$(date +%s)

MP3_FILE_FULL_PATH="$MP3_DIR/$MP3_FILE"
CSV_FILE_FULL_PATH="$MP3_FILE_FULL_PATH.csv"
SQL_FILE_FULL_PATH="$MP3_FILE_FULL_PATH.sql"

printf "MP3_FILE_FULL_PATH=$MP3_FILE_FULL_PATH\n"
printf "CSV_FILE_FULL_PATH=$CSV_FILE_FULL_PATH\n"
printf "SQL_FILE_FULL_PATH=$SQL_FILE_FULL_PATH\n"

if [! -f "$CSV_FILE_FULL_PATH" ]
  then
  echo "PANIC! File not found: $CSV_FILE_FULL_PATH\n"
  exit 0;
fi
  
printf  "File found: $CSV_FILE_FULL_PATH\n"

INSERT=$(cat $CSV_FILE_FULL_PATH | awk -F "," '{printf("insert into track (name, low, high, percent_low, percent_high) values (\x27%s\x27, \x27%d\x27, \x27%d\x27, \x27%.17g\x27, \x27%.17g\x27); \n", $1, $2, $3, $4, $5)}')

#printf "INSERT=$INSERT\n"

################################################################################
# Generate an SQL file that looks something like this:
#
# use music;
# INSERT INTO track (name, low, high, percent_low, percent_high)
# VALUES ('HELLO_WORLD', '85', '97', '0.467032967032967' , '0.532967032967033');
# SELECT LAST_INSERT_ID();
################################################################################

printf "use music;\n"                > $SQL_FILE_FULL_PATH
printf "$INSERT\n"                  >> $SQL_FILE_FULL_PATH
printf "SELECT LAST_INSERT_ID();\n" >> $SQL_FILE_FULL_PATH

printf "$SQL_FILE_FULL_PATH:\n"
cat $SQL_FILE_FULL_PATH

ENDTIME=$(date +%s)
time2RunGenerateSQL="$(($ENDTIME - $STARTTIME))"


################################################################################
# Save summary statst to a relational database
################################################################################

STARTTIME=$(date +%s)
#DB_ID=$(mysql -N -B  < $SQL_FILE_FULL_PATH)
DB_ID=$(mysql -N -B -h $DB_HOST -P 3306 < $SQL_FILE_FULL_PATH)
ENDTIME=$(date +%s)
time2ExecuteSQL="$(($ENDTIME - $STARTTIME))"

#export DB_ID
printf "DB_ID=$DB_ID\n"

echo "muah hah hah"

printf "time2GenerateRawFile=%f\n", "$time2GenerateRawFile"
printf "      time2RunOctave=%f\n", "$time2RunOctave"
printf "    time2GenerateSQL=%f\n", "$time2GenerateSQL"
printf "     time2ExecuteSQL=%f\n", "$time2ExecuteSQL"

exit $DB_ID
