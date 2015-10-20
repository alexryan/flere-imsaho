#!/bin/bash

################################################################################
# Upload local files to the ec2 instance on the aws cloud
################################################################################

EXCLUDES='--exclude="octave-workspace" --exclude=".git/*" --exclude="*.mp3" --exclude="*.MP3" --exclude="*.m4a" --exclude="*.m4p" --exclude="*.wav" --exclude="*.raw" --exclude="*.png"'

# sql
rsync --progress $EXCLUDES -rave "ssh -i $KEYS/music2.pem" $FLERE_IMSAHO/data/mysql ubuntu@music:/mnt/flere-imsaho/data




