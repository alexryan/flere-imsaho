#!/bin/sh

directory="$FLERE_IMSAHO/data/playlists/output/test-set/true-positives"
#echo "$directory"
python3 $FLERE_IMSAHO/python/generate-html.py $directory
theFile="$directory/images.html"
ls -l $theFile
head -n 10 $theFile

directory="$FLERE_IMSAHO/data/playlists/output/test-set/true-negatives"
#echo "$directory"
python3 $FLERE_IMSAHO/python/generate-html.py $directory
theFile="$directory/images.html"
ls -l $theFile
head -n 10 $theFile

directory="$FLERE_IMSAHO/data/playlists/output/test-set/false-positives"
#echo "$directory"
python3 $FLERE_IMSAHO/python/generate-html.py $directory
theFile="$directory/images.html"
ls -l $theFile
head -n 10 $theFile

directory="$FLERE_IMSAHO/data/playlists/output/test-set/false-negatives"
#echo "$directory"
python3 $FLERE_IMSAHO/python/generate-html.py $directory
theFile="$directory/images.html"
ls -l $theFile
head -n 10 $theFile


