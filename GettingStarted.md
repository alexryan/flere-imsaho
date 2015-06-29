
# Getting Started

Teach a machine learning algroithm how to recognize the intensity of music.  
Note: Initially we are just distinguishing between 2 categories of "low intensity" and "high intensity".  
Next stage is assign a range of intensity values (called "I-values") between 0 and 1.


How to setup the environment on Mac OS X Yosemite.

## Install the tools:


If you don't already have homebrew installed, install it like so:
```javascript
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
If you do have it installed, upgrade to the latest version like so:
$ brew update && brew upgrade


### Audio Processing Tools
 ffmpeg & sox are used for audio file conversion.

Use homebrew to install ffmpeg
```javascript
$ brew install ffmpeg --with-tools
```

Use homebrew to install sox
```javascript
$ brew install sox --with-flac --with-lame
```

### Machine Learning Tools
octave is used to run the actual machine learning algorithm.

Follow thesse instructions to install octave on yosemite
http://adampash.com/how-to-install-octave/

tap the science formulae
```javascript
$ brew tap homebrew/science
```

install some Octave dependencies
```javascript
$ brew install gfortran
```

on Yosemite, you gfortran isn't available so use this instead
```javascript
$ brew install gcc
```

You may also need to install mactex
(see http://tex.stackexchange.com/questions/97183/what-are-the-practical-differences-between-installing-latex-from-mactex-or-macpo)

```javascript
brew install Caskroom/cask/mactex
export PATH=$PATH:/usr/texbin
```

install octave
```javascript
$ brew install octave --with-x11
```

install fltk for gnuplot
```javascript
$ brew install fltk
```

install gnuplot (this may be installed as part of octave now)
```javascript
$ brew install gnuplot --with-x11
```

Last, you need to edit your .octaverc file to get gnuplot to play nicely with Octave. So, in your home directory, create a new .octaverc file and paste the following:

Run this command in the shell to create the file
```javascript
$ touch ~/.octaverc
```

Open the file in a text editor and add these lines:
```javascript
setenv ("GNUTERM", "X11")
# below is optional; changes the prompt to two chevron and gets rid of the long Octave x.x.x >> prompt
PS1('❯❯ ')
```


## Get the source:
cd to the directory where you want to source to be downloaded and
run the "git clone" command.
For example:
```javascript
$ cd /Users/alexryan/alpine/git
$ git clone https://github.com/alexryan/flere-imsaho.git flere-imsaho
```

This will create a directory containing all of the project files called
flere-imsaho in the current directory like so:
/Users/alexryan/alpine/git/flere-imsaho


## Setup the environment variables in your ~/.bash_profile

(1) Add environment variables to your ~/.bash_profile:
```javascript
export FLERE_IMSAHO=/Users/alexryan/alpine/git/flere-imsaho
```
(2) Add the directory where the scripts reside to your path:
```javascript
export PATH=$PATH:$FLERE_IMSAHO/bin
```
(3) Then execute the environment file in the current shell like so:
```javascript
$ source ~/.bash_profile
```


## Generate audio files
Now you are ready to go.  
Put the MP3 files that you want to work with in this directory:  
```javascript
$FLERE_IMSAHO/data/audio/full
```
Rename them according to this convention:  
Artist_Name-Title_of_song.mp3  
Replace all spaces with underscores.  
Separate the name of the artist and the name of the track with a hyphen.  
Running the following script with extract multiple 2 second snippets from
these songs in the $FLERE_IMSAHO/data/snippets directory.

```javascript
$ cd $FLERE_IMSAHO/bin
$ ./train-part1.sh
$ ls -lF $FLERE_IMSAHO/data/audio/snippets
```

You should see results that look something like this ...
```javascript
-rw-r--r-- 1 alexryan staff 32600 Jun 24 16:32 Bach-Air_on_a_G_string.30.mp3
-rw-r--r-- 1 alexryan staff 32600 Jun 24 16:32 Bach-Air_on_a_G_string.40.mp3
-rw-r--r-- 1 alexryan staff 32600 Jun 24 16:32 Bach-Air_on_a_G_string.50.mp3
-rw-r--r-- 1 alexryan staff 32600 Jun 24 16:32 Bach-Air_on_a_G_string.60.mp3
-rw-r--r-- 1 alexryan staff 32600 Jun 24 16:32 Bach-Air_on_a_G_string.70.mp3
-rw-r--r-- 1 alexryan staff 32600 Jun 24 16:32 Bach-Air_on_a_G_string.80.mp3
```

## Manually sort the audio files by intensity in iTunes

Import these files into an iTunes playlist.  
Listen to each clip and manually sort them from least intensity to maximum intensity.  

## Extracted sorted audio files from iTunes

When you are done sorting, export the sorted list as an m3u8 file  
(called "experiment.m3u8")  
via "File > Library > Export Playlist"  
to this location:  
```javascript
$FLERE_IMSAHO/data/audio
```

Neat trick:  
If you double-click on this .m3u8 file in the finder, your playlist should start
playing in iTunes.
Kewwwwwwllllll eh?

## Generate a CSV list of the sorted audio files and add a tag to each

We need to extract just the sorted list of MP3 files from it into a csv file.  
Do that by running the shell script:

```javascript
$ train-part2.sh
```

Here's what you should see after running the command

```javascript
$ ls -lF $FLERE_IMSAHO/data/audio/experiment.*
-rw-r--r-- 1 alexryan staff  5091 Jun 27 00:09 /Users/alexryan/alpine/git/flere-imsaho/data/audio/experiment.csv
-rw-r--r-- 1 alexryan staff 25859 Jun 25 16:35 /Users/alexryan/alpine/git/flere-imsaho/data/audio/experiment.m3u8
 ```

So now we have a sorted list of songs that looks like this ...
```javascript
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
```

To each song we need to add a "label"  
currently we are just using a logistic regression algorithm  
so label each song with a 0 or 1 like so.  
0 = low intensity,  
1 = high intensity  
This can be done by importing the csv file into a tool like Google Sheets
adding a new column with the labels.

```javascript
$ cat $FLERE_IMSAHO/data/audio/experiment.csv
Divinity-Ethereal_Void.30,0
Divinity-Ethereal_Void.40,0
Divinity-Ethereal_Void.50,0
...
Pantera-Fucking_Hostile.50,1
Pantera-Fucking_Hostile.60,1
Pantera-Fucking_Hostile.70,1
Pantera-Fucking_Hostile.80,1
```

## Randomly split the data into training and test sets and generate a matlab data file for each

```javascript
$ train-part3.sh
```
