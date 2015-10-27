#!/bin/bash

################################################################################
# Upload local files to the ec2 instance on the aws cloud
################################################################################

# matlab data files
rsync --progress -exclude="*.raw" -rave "ssh -i $KEYS/music2.pem" $FLERE_IMSAHO/data/audio/clips ubuntu@music:/mnt/flere-imsaho/data/audio



