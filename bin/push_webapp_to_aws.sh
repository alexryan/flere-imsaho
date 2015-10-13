#!/bin/bash

ls -lF /Users/alexryan/alpine/git/flereImsahoWebApp/flereImsaho.war
#scp -i ~/keys/music2.pem /Users/alexryan/alpine/git/flereImsahoWebApp/flereImsaho.war ubuntu@music:/home/ubuntu/tmp
rsync --progress -rave "ssh -i $KEYS/music2.pem" /Users/alexryan/alpine/git/flereImsahoWebApp/flereImsaho.war ubuntu@music:/home/ubuntu/tmp


