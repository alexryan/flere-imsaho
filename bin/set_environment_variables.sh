################################################################################
# This script is just for testing the processing of MP3 file uploaded via HTTP by the user
# It sets the same environment variables that would normally be set by the web server (tomcat)
# before it invokes the shell script to process the uploaded mp3 file.
# NOTE
# source set_environment_variables.sh
# before running the script to process the mp3 file
################################################################################

export FLERE_IMSAHO=/Users/alexryan/alpine/git/flere-imsaho
export MP3_DIR=/Users/alexryan/alpine/git/flere-imsaho/data/audio/user
export MP3_FILE=Black_Eyed_Peas_-_I_Gotta_Feeling_Lyrics.mp3
export RAW_FILE=Black_Eyed_Peas_-_I_Gotta_Feeling_Lyrics.mono-sr0500-ss16.raw
export PNG_DIR=/Users/alexryan/alpine/git/flere-imsaho/data/audio/user/wtpwebapps/flereImsaho
export PNG_FILE=Black_Eyed_Peas_-_I_Gotta_Feeling_Lyrics.png
export WEIGHTS=/Users/alexryan/alpine/git/flere-imsaho/data/matlab/flere-imsaho-weights.mat
