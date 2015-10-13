#!/bin/bash

################################################################################
# Upload local files to the ec2 instance on the aws cloud
################################################################################

# rsync --progress --exclude=".git/*" --exclude="*.mp3" --exclude="*.MP3" --exclude="*.m4a" --exclude="*.m4p" --exclude="*.wav" --exclude="*.raw" --exclude="*.png" -rave "ssh -i $KEYS/music2.pem" $FLERE_IMSAHO ubuntu@music:/mnt


EXCLUDES='--exclude="octave-workspace" --exclude=".git/*" --exclude="*.mp3" --exclude="*.MP3" --exclude="*.m4a" --exclude="*.m4p" --exclude="*.wav" --exclude="*.raw" --exclude="*.png"'

# shell scripts
rsync --progress $EXCLUDES -rave "ssh -i $KEYS/music2.pem" $FLERE_IMSAHO/bin ubuntu@music:/mnt/flere-imsaho

# octave source code
rsync --progress $EXCLUDES -rave "ssh -i $KEYS/music2.pem" $FLERE_IMSAHO/src ubuntu@music:/mnt/flere-imsaho

# matlab data files
rsync --progress $EXCLUDES -rave "ssh -i $KEYS/music2.pem" $FLERE_IMSAHO/data/matlab ubuntu@music:/mnt/flere-imsaho/data



