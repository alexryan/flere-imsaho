#!/bin/bash

#echo "hello" | tee $FLERE_IMSAHO/data/audio/user/process-uploaded-mp3.log
$FLERE_IMSAHO/bin/process-uploaded-mp3.sh | tee $FLERE_IMSAHO/data/audio/user/process-uploaded-mp3.log
#echo "hello again" | tee $FLERE_IMSAHO/data/audio/user/process-uploaded-mp3.log

