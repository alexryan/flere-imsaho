
How to setup the environment on Mac OS X.

################################################################################
# Install the tools:
################################################################################

# Install homebrew:
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Use homebrew to install ffmpeg
  brew install ffmpeg --with-tools

# Use homebrew to install eox
  brew install sox --with-flac --with-lame


################################################################################
# Get the source:
################################################################################
cd to the directory where you want to source to be downloaded and
run the "git clone" command.
For example:
  $cd /Users/alexryan/alpine/git
  $git clone https://alpineresearchsv.unfuddle.com/git/alpineresearchsv_machine-learning/ machineLearning


################################################################################
# Setup the environment variables:
################################################################################
Add environment variable to your ~/.bash_profile:
set ALPINE_GIT to point to the location where you put the source
For example:
  export ALPINE_GIT=/Users/alexryan/alpine/git

Then execute the environment file in the current shell like so:
  $source ~/.bash_profile


################################################################################
# Now you are ready to go
# Put the MP3 files that you want to work with in this directory:
# $ALPINE_GIT/machineLearning/data/audio
# Rename them according to this convention:
# Artist_Name-Title_of_song.mp3
# Replace all spaces with underscores.
# Separate the name of the artist and the name of the track with a hyphen.
#
# Running the following script with extract multiple 2 second snippets from 
# these songs in the $ALPINE_GIT/machineLearning/data/snippets directory.
################################################################################
  cd $ALPINE_GIT/machineLearning/bin
  ./train1.sh
  ls -lF $ALPINE_GIT/machineLearning/data/audio/snippets


################################################################################
# You should see results that look something like this ...
################################################################################
-rw-r--r-- 1 alexryan staff 32600 Jun 24 16:32 Bach-Air_on_a_G_string.30.mp3
-rw-r--r-- 1 alexryan staff 32600 Jun 24 16:32 Bach-Air_on_a_G_string.40.mp3
-rw-r--r-- 1 alexryan staff 32600 Jun 24 16:32 Bach-Air_on_a_G_string.50.mp3
-rw-r--r-- 1 alexryan staff 32600 Jun 24 16:32 Bach-Air_on_a_G_string.60.mp3
-rw-r--r-- 1 alexryan staff 32600 Jun 24 16:32 Bach-Air_on_a_G_string.70.mp3
-rw-r--r-- 1 alexryan staff 32600 Jun 24 16:32 Bach-Air_on_a_G_string.80.mp3


################################################################################
# Import these files into an iTunes playlist
# Manually sort them from least intensity to maximum intensity
# When you are done sorting, export the sorted list as an .m3u8 file
# via "File > Library > Export Playlist"
# to this location:
# $ALPINE_GIT/machineLearning/data/audio
#
# If you double-click on this file in the finder, your playlist should start
# playing in iTunes.
#
# We need to extract just the sorted list of MP3 files from it into a csv file.
# Do that by running the "m3u8-to-csv.sh" shell script:
################################################################################
$pwd
/Users/alexryan/alpine/git/machineLearning/data/audio
$ls -lF
total 120
-rw-r--r--   1 alexryan staff 25859 Jun 25 16:35 experiment.m3u8
drwxr-xr-x  58 alexryan staff  1972 Jun 24 15:52 full/
-rwxr-xr-x   1 alexryan staff  1325 Jun 26 08:54 m3u8-to-csv.sh*
drwxr-xr-x 170 alexryan staff  5780 Jun 24 16:32 snippets/
$./m3u8-to-csv.sh experiment.m3u8 
outfile:experiment.csv
$ls -lF
total 76
-rw-r--r--   1 alexryan staff  5831 Jun 26 11:23 experiment.csv
-rw-r--r--   1 alexryan staff 25859 Jun 25 16:35 experiment.m3u8
drwxr-xr-x  58 alexryan staff  1972 Jun 24 15:52 full/
-rwxr-xr-x   1 alexryan staff  1325 Jun 26 08:54 m3u8-to-csv.sh*
drwxr-xr-x 170 alexryan staff  5780 Jun 24 16:32 snippets/
  


