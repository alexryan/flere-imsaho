#!/bin/sh

################################################################################
# test-set-true-positives
################################################################################
matrix="Xtest"
rows="/Users/alexryan/alpine/git/flere-imsaho/data/playlists/output/test-set-true-positives-with-indices.csv"
directory="/Users/alexryan/alpine/git/flere-imsaho/data/playlists/output/test-set/true-positives"
$FLERE_IMSAHO/src/generate_plots.m $matrix $rows $directory

################################################################################
# test-set-true-negatives
################################################################################
rows="/Users/alexryan/alpine/git/flere-imsaho/data/playlists/output/test-set-true-negatives-with-indices.csv"
directory="/Users/alexryan/alpine/git/flere-imsaho/data/playlists/output/test-set/true-negatives"
$FLERE_IMSAHO/src/generate_plots.m $matrix $rows $directory

################################################################################
# test-set-false-positives
################################################################################
rows="/Users/alexryan/alpine/git/flere-imsaho/data/playlists/output/test-set-false-positives-with-indices.csv"
directory="/Users/alexryan/alpine/git/flere-imsaho/data/playlists/output/test-set/false-positives"
$FLERE_IMSAHO/src/generate_plots.m $matrix $rows $directory

################################################################################
# test-set-false-negatives
################################################################################
rows="/Users/alexryan/alpine/git/flere-imsaho/data/playlists/output/test-set-false-negatives-with-indices.csv"
directory="/Users/alexryan/alpine/git/flere-imsaho/data/playlists/output/test-set/false-negatives"
$FLERE_IMSAHO/src/generate_plots.m $matrix $rows $directory


