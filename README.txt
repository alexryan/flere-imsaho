
How to setup the environment on Mac OS X.

################################################################################
# Install the tools:
################################################################################

If you don't already have homebrew installed, install it like so:
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

If you do have it installed, upgrade to the latest version like so:
$ brew update && brew upgrade

################################################################################
# Audio Processing Tools
# ffmpeg & sox are used for audio file conversion.
################################################################################

Use homebrew to install ffmpeg
$ brew install ffmpeg --with-tools

Use homebrew to install sox
$ brew install sox --with-flac --with-lame

################################################################################
# Machine Learning Tools
# octave is used to run the actual machine learning algorithm.
################################################################################

Follow thesse instructions to install octave on yosemite
http://adampash.com/how-to-install-octave/

# tap the science formulae
$ brew tap homebrew/science

install some Octave dependencies
$ brew install gfortran

on Yosemite, you gfortran isn't available so use this instead
$ brew install gcc

# You may also need to install mactex (see http://tex.stackexchange.com/questions/97183/what-are-the-practical-differences-between-installing-latex-from-mactex-or-macpo)
brew install Caskroom/cask/mactex
export PATH=$PATH:/usr/texbin

install octave
$ brew install octave --with-x11

install fltk for gnuplot
$ brew install fltk

install gnuplot (this may be installed as part of octave now)
$ brew install gnuplot --with-x11

Last, you need to edit your .octaverc file to get gnuplot to play nicely with Octave. So, in your home directory, create a new .octaverc file and paste the following:

Run this command in the shell to create the file
$ touch ~/.octaverc

Open the file in a text editor and add these lines:
setenv ("GNUTERM", "X11")
# below is optional; changes the prompt to two chevron
# and gets rid of the long Octave x.x.x >> prompt
PS1('❯❯ ')


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

(1) Add environment variables to your ~/.bash_profile:
export FLERE_IMSAHO=/Users/alexryan/alpine/git/flere-imsaho

(2) Add the directory where the scripts reside to your path:
export PATH=$PATH:$FLERE_IMSAHO/bin

(3) Then execute the environment file in the current shell like so:
$ source ~/.bash_profile


################################################################################
# Now you are ready to go
# Put the MP3 files that you want to work with in this directory:
# $FLERE_IMSAHO/data/audio
# Rename them according to this convention:
# Artist_Name-Title_of_song.mp3
# Replace all spaces with underscores.
# Separate the name of the artist and the name of the track with a hyphen.
#
# Running the following script with extract multiple 2 second snippets from 
# these songs in the $FLERE_IMSAHO/data/snippets directory.
################################################################################
$ cd $FLERE_IMSAHO/bin
$ ./train-part1.sh
$ ls -lF $FLERE_IMSAHO/data/audio/snippets


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
# $FLERE_IMSAHO/data/audio
#
# Neat trick:
# If you double-click on this file in the finder, your playlist should start
# playing in iTunes.
# Kewwwwwwllllll eh?
#
# We need to extract just the sorted list of MP3 files from it into a csv file.
# Do that by running the "m3u8-to-csv.sh" shell script:
################################################################################

To generate the csv file, run this command:
$pwd
$ train-part2.sh 

Here's what you should see after running the command
$ls -lF $FLERE_IMSAHO/data/audio/experiment.*
-rw-r--r-- 1 alexryan staff  5091 Jun 27 00:09 /Users/alexryan/alpine/git/machineLearning/data/audio/experiment.csv
-rw-r--r-- 1 alexryan staff 25859 Jun 25 16:35 /Users/alexryan/alpine/git/machineLearning/data/audio/experiment.m3u8

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
  

################################################################################
# So now we have a sorted list of songs that looks like this ...
################################################################################
$ head $FLERE_IMSAHO/data/audio/experiment.csv 
Divinity-Ethereal_Void.30
Divinity-Ethereal_Void.40
Divinity-Ethereal_Void.50
Divinity-Ethereal_Void.60
Divinity-Ethereal_Void.70
Divinity-Ethereal_Void.80
Deva_Premal-Devi_Prayer.30
Deva_Premal-Devi_Prayer.40
Deva_Premal-Devi_Prayer.50
Deva_Premal-Devi_Prayer.60

################################################################################
# To each song we need to add a "label"
# currently we are just using a logistic regression algorithm
# so label each song with a 0 or 1 like so.
# wherein 0 = low intensity, 
# 1 = high intensity
################################################################################
$ cat $FLERE_IMSAHO/data/audio/experiment.csv 
Divinity-Ethereal_Void.30,0
Divinity-Ethereal_Void.40,0
Divinity-Ethereal_Void.50,0
...
Pantera-Fucking_Hostile.50,1
Pantera-Fucking_Hostile.60,1
Pantera-Fucking_Hostile.70,1
Pantera-Fucking_Hostile.80,1


