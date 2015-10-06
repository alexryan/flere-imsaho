#!/bin/sh

OCTAVE_PATH=$FLERE_IMSAHO/src
octave --path $OCTAVE_PATH $FLERE_IMSAHO/src/generate_prediction_data.m

cd $FLERE_IMSAHO/data/playlists/output

################################################################################
# Generate 3 "predictions" files
#   1 for each of the training, validation and test sets.
#   > training-set-predictions.csv
#   > validation-set-predictions.csv
#   > test-set-predictions.csv
#
# Format:
#   clip_name,actual,prediction,probability_of_1,probability_of_2
#
# > clip_name:        The file name of the clip (minus the file extension)
# > actual:           an integer; 1=negative or "low intensity"
#                                 2=positive or "high intensity"
# > prediction:       an integer; 1=negative or "low intensity"
#                                 2=positive or "high intensity"
# > probability_of_1: floating point number
#                     the computed probability of "low intensity"
# > probability_of_2: floating point number
#                     the computed probability of "high intensity"
#
# Also, generate 3x4 iTunes playlists that can be immediately imported into iTunes:
# For each of the 3 data sets (training, validation and test)
# generate 4 playlists:
#   2 lists of "CORRECT" predicitons
#     > true-positives: predicted="high intensity" and actual="high intensity"
#     > true-negatves:  predicted="low intensity"  and actual="low intensity"
#   2 lists of "INCORRECT" predicitons
#     > false-positives: predicted="high intensity" and actual="LOW intensity"
#     > false-negatves:  predicted="low intensity"  and actual="HIGH intensity"
#
# Sample output:
# Break down of validation-set predictions ...
#
# number of predictions:       12110
# number of predictions (sum): 12110
# number of true  negatives:    5431 or 44.8%
# number of false negatives:     666 or 5.5%
# number of false positives:    1010 or 8.3%
# number of true  positives:    5003 or 41.3%
#
# Generating M3U8 playlists  ...
#
# outfile:training-set-false-negatives.m3u8
# outfile:training-set-false-positives.m3u8
# outfile:training-set-true-negatives.m3u8
# outfile:training-set-true-positives.m3u8
# 
# Pre-requisites:
#   These files identifying the "actuals" already exist in the directory:
#   > training-set.csv
#   > validation-set.csv
#   > test-set.csv
#
################################################################################

#cat header-predictions.csv | cat - training-set-predictions.csv > /tmp/out && mv /tmp/out training-set-predictions.csv
#cat header-predictions.csv | cat - validation-set-predictions.csv > /tmp/out && mv /tmp/out validation-set-predictions.csv
#cat header-predictions.csv | cat - test-set-predictions.csv > /tmp/out && mv /tmp/out test-set-predictions.csv

printf "\nPre-Join:\n"
printf "\ntraining-set.csv:\n"
head -n 3 training-set.csv
printf "\ntraining-set-predictions.csv:\n"
head -n 3 training-set-predictions.csv

csvjoin -q \" training-set.csv training-set-predictions.csv > magic.csv
rm training-set-predictions.csv
mv magic.csv training-set-predictions.csv

printf "\ntraining-set-predictions.csv:\n"
head training-set-predictions.csv

csvjoin -q \" validation-set.csv validation-set-predictions.csv > magic.csv
rm validation-set-predictions.csv
mv magic.csv validation-set-predictions.csv

printf "\nvalidation-set-predictions.csv:\n"
head validation-set-predictions.csv

csvjoin -q \" test-set.csv test-set-predictions.csv > magic.csv
rm test-set-predictions.csv
mv magic.csv test-set-predictions.csv

printf "\ntest-set-predictions.csv:\n"
head test-set-predictions.csv


################################################################################
#Add some quotation marks to the first column of the data files.
#########################################################################################

cat training-set-predictions.csv | awk -F, '{sub($1, "\"&\""); print}' > temp.csv
mv temp.csv training-set-predictions.csv
#printf "training-set-preditions.csv:\n"
#head training-set-predictions.csv

cat validation-set-predictions.csv | awk -F, '{sub($1, "\"&\""); print}' > temp.csv
mv temp.csv validation-set-predictions.csv
#printf "validation-set-preditions.csv:\n"
#head validation-set-predictions.csv

cat test-set-predictions.csv | awk -F, '{sub($1, "\"&\""); print}' > temp.csv
mv temp.csv test-set-predictions.csv
#printf "test-set-preditions.csv:\n"
#head test-set-predictions.csv

################################################################################
# Add some headers
# This is necessary to make "csvsort" work properly
################################################################################
cat header.csv | cat - training-set-predictions.csv > /tmp/out && mv /tmp/out training-set-predictions.csv
cat header.csv | cat - validation-set-predictions.csv > /tmp/out && mv /tmp/out validation-set-predictions.csv
cat header.csv | cat - test-set-predictions.csv > /tmp/out && mv /tmp/out test-set-predictions.csv

printf "\nheaders added ...\n"

printf "\ntraining-set-preditions.csv:\n"
head -n 3 training-set-predictions.csv

printf "\nvalidation-set-preditions.csv:\n"
head -n 3 validation-set-predictions.csv

printf "\ntest-set-preditions.csv:\n"
head -n 3 test-set-predictions.csv


################################################################################
# For each prediction file ...
# Break it into 4 files
#   1: true positives:  predicted="high intensity" + actual="high intensity"
#   2: true negatives:  predicted="low intensity"  + actual="low intensity"
#   3: false positives: predicted="high intensity" + actual="low intensity"
#   4: false negatives: predicted="low intensity"  + actual="high intensity"
################################################################################


################################################################################
# Training Set
################################################################################

# Sort the predictions first by actuals and then by predictions: ((1,1),(1,2),(2,1),(2,2))
csvsort training-set-predictions.csv -c 2,3 > temp-full.csv

# Get only the actuals and predictions
# 1,1
# ...
# 1,2
cut -f 2,3 -d , temp-full.csv > temp-short.csv

# Get the line number that each of the 4 groups starts on

group1Start=1
group2Start=$(grep -m 1 -n "1,2" temp-short.csv | cut -f1 -d :)
group3Start=$(grep -m 1 -n "2,1" temp-short.csv | cut -f1 -d :)
group4Start=$(grep -m 1 -n "2,2" temp-short.csv | cut -f1 -d :)
let group1End="$group2Start - 1"
let group2End="$group3Start - 1"
let group3End="$group4Start - 1"
group4End=$(wc -l temp-short.csv | cut -d' ' -f1)

printf "\nExtracting records from sorted data set ...\n\n"
printf "group1: $group1Start to $group1End\n"
printf "group2: $group2Start to $group2End\n"
printf "group3: $group3Start to $group3End\n"
printf "group4: $group4Start to $group4End\n"

sed -n ${group1Start},${group1End}p temp-full.csv > training-set-true-negatives.csv
sed -n ${group2Start},${group2End}p temp-full.csv > training-set-false-negatives.csv
sed -n ${group3Start},${group3End}p temp-full.csv > training-set-false-positives.csv
sed -n ${group4Start},${group4End}p temp-full.csv > training-set-true-positives.csv

totalCount1=$(wc -l training-set-predictions.csv | cut -d' ' -f1)
trueNegativeCount=$(wc -l training-set-true-negatives.csv | cut -d' ' -f1)
falseNegativeCount=$(wc -l training-set-false-negatives.csv | cut -d' ' -f1)
falsePositiveCount=$(wc -l training-set-false-positives.csv | cut -d' ' -f1)
truePositiveCount=$(wc -l training-set-true-positives.csv | cut -d' ' -f1)

trueNegativePercent=$(bc <<< "scale=10; $trueNegativeCount / $totalCount1 * 100")
falseNegativePercent=$(bc <<< "scale=10; ($falseNegativeCount / $totalCount1) * 100")
falsePositivePercent=$(bc <<< "scale=10; $falsePositiveCount / $totalCount1 * 100")
truePositivePercent=$(bc <<< "scale=10; $truePositiveCount / $totalCount1 * 100")

let totalCount2="$trueNegativeCount + $falseNegativeCount + $falsePositiveCount + $truePositiveCount"

printf "\nBreak down of validation-set predictions ...\n\n"
printf "number of predictions:       %5d \n" "${totalCount1}"
printf "number of predictions (sum): %5d \n" "${totalCount2}"
printf "number of true  negatives:   %5d or %2.1f%%\n"  "${trueNegativeCount}" "${trueNegativePercent}"
printf "number of false negatives:   %5d or %2.1f%%\n" "${falseNegativeCount}" "${falseNegativePercent}"
printf "number of false positives:   %5d or %2.1f%%\n" "${falsePositiveCount}" "${falsePositivePercent}"
printf "number of true  positives:   %5d or %2.1f%%\n" "${truePositiveCount}"  "${truePositivePercent}"

printf "\nGenerating M3U8 playlists  ...\n\n"
csv-to-m3u8.sh training-set-false-negatives.csv
csv-to-m3u8.sh training-set-false-positives.csv
csv-to-m3u8.sh training-set-true-negatives.csv
csv-to-m3u8.sh training-set-true-positives.csv


################################################################################
# Validation Set
################################################################################

# Sort the predictions first by actuals and then by predictions: ((1,1),(1,2),(2,1),(2,2))
csvsort validation-set-predictions.csv -c 2,3 > temp-full.csv

# Get only the actuals and predictions
# 1,1
# ...
# 1,2
cut -f 2,3 -d , temp-full.csv > temp-short.csv

# Get the starting and ending line numbers for each of the 4 groups

group1Start=1
group2Start=$(grep -m 1 -n "1,2" temp-short.csv | cut -f1 -d :)
group3Start=$(grep -m 1 -n "2,1" temp-short.csv | cut -f1 -d :)
group4Start=$(grep -m 1 -n "2,2" temp-short.csv | cut -f1 -d :)
let group1End="$group2Start - 1"
let group2End="$group3Start - 1"
let group3End="$group4Start - 1"
group4End=$(wc -l temp-short.csv | cut -d' ' -f1)

printf "\nExtracting records from sorted data set ...\n\n"
printf "group1: $group1Start to $group1End\n"
printf "group2: $group2Start to $group2End\n"
printf "group3: $group3Start to $group3End\n"
printf "group4: $group4Start to $group4End\n"

sed -n ${group1Start},${group1End}p temp-full.csv > validation-set-true-negatives.csv
sed -n ${group2Start},${group2End}p temp-full.csv > validation-set-false-negatives.csv
sed -n ${group3Start},${group3End}p temp-full.csv > validation-set-false-positives.csv
sed -n ${group4Start},${group4End}p temp-full.csv > validation-set-true-positives.csv

totalCount1=$(wc -l validation-set-predictions.csv | cut -d' ' -f1)
trueNegativeCount=$(wc -l validation-set-true-negatives.csv | cut -d' ' -f1)
falseNegativeCount=$(wc -l validation-set-false-negatives.csv | cut -d' ' -f1)
falsePositiveCount=$(wc -l validation-set-false-positives.csv | cut -d' ' -f1)
truePositiveCount=$(wc -l validation-set-true-positives.csv | cut -d' ' -f1)

trueNegativePercent=$(bc <<< "scale=10; $trueNegativeCount / $totalCount1 * 100")
falseNegativePercent=$(bc <<< "scale=10; ($falseNegativeCount / $totalCount1) * 100")
falsePositivePercent=$(bc <<< "scale=10; $falsePositiveCount / $totalCount1 * 100")
truePositivePercent=$(bc <<< "scale=10; $truePositiveCount / $totalCount1 * 100")

let totalCount2="$trueNegativeCount + $falseNegativeCount + $falsePositiveCount + $truePositiveCount"

printf "\nBreak down of training-set predictions ...\n\n"
printf "number of predictions:       %5d \n" "${totalCount1}"
printf "number of predictions (sum): %5d \n" "${totalCount2}"
printf "number of true  negatives:   %5d or %2.1f%%\n"  "${trueNegativeCount}" "${trueNegativePercent}"
printf "number of false negatives:   %5d or %2.1f%%\n" "${falseNegativeCount}" "${falseNegativePercent}"
printf "number of false positives:   %5d or %2.1f%%\n" "${falsePositiveCount}" "${falsePositivePercent}"
printf "number of true  positives:   %5d or %2.1f%%\n" "${truePositiveCount}"  "${truePositivePercent}"

printf "\nGenerating M3U8 playlists  ...\n\n"
csv-to-m3u8.sh validation-set-false-negatives.csv
csv-to-m3u8.sh validation-set-false-positives.csv
csv-to-m3u8.sh validation-set-true-negatives.csv
csv-to-m3u8.sh validation-set-true-positives.csv

################################################################################
# Test Set
################################################################################

# Sort the predictions first by actuals and then by predictions: ((1,1),(1,2),(2,1),(2,2))
csvsort test-set-predictions.csv -c 2,3 > temp-full.csv

# Get only the actuals and predictions
# 1,1
# ...
# 1,2
cut -f 2,3 -d , temp-full.csv > temp-short.csv

# Get the starting and ending line numbers for each of the 4 groups

group1Start=1
group2Start=$(grep -m 1 -n "1,2" temp-short.csv | cut -f1 -d :)
group3Start=$(grep -m 1 -n "2,1" temp-short.csv | cut -f1 -d :)
group4Start=$(grep -m 1 -n "2,2" temp-short.csv | cut -f1 -d :)
let group1End="$group2Start - 1"
let group2End="$group3Start - 1"
let group3End="$group4Start - 1"
group4End=$(wc -l temp-short.csv | cut -d' ' -f1)

printf "\nExtracting records from sorted data set ...\n\n"
printf "group1: $group1Start to $group1End\n"
printf "group2: $group2Start to $group2End\n"
printf "group3: $group3Start to $group3End\n"
printf "group4: $group4Start to $group4End\n"

sed -n ${group1Start},${group1End}p temp-full.csv > test-set-true-negatives.csv
sed -n ${group2Start},${group2End}p temp-full.csv > test-set-false-negatives.csv
sed -n ${group3Start},${group3End}p temp-full.csv > test-set-false-positives.csv
sed -n ${group4Start},${group4End}p temp-full.csv > test-set-true-positives.csv

totalCount1=$(wc -l test-set-predictions.csv | cut -d' ' -f1)
trueNegativeCount=$(wc -l test-set-true-negatives.csv | cut -d' ' -f1)
falseNegativeCount=$(wc -l test-set-false-negatives.csv | cut -d' ' -f1)
falsePositiveCount=$(wc -l test-set-false-positives.csv | cut -d' ' -f1)
truePositiveCount=$(wc -l test-set-true-positives.csv | cut -d' ' -f1)

trueNegativePercent=$(bc <<< "scale=10; $trueNegativeCount / $totalCount1 * 100")
falseNegativePercent=$(bc <<< "scale=10; ($falseNegativeCount / $totalCount1) * 100")
falsePositivePercent=$(bc <<< "scale=10; $falsePositiveCount / $totalCount1 * 100")
truePositivePercent=$(bc <<< "scale=10; $truePositiveCount / $totalCount1 * 100")

let totalCount2="$trueNegativeCount + $falseNegativeCount + $falsePositiveCount + $truePositiveCount"

printf "\nBreak down of test-set predictions ...\n\n"
printf "number of predictions:       %5d \n" "${totalCount1}"
printf "number of predictions (sum): %5d \n" "${totalCount2}"
printf "number of true  negatives:   %5d or %2.1f%%\n"  "${trueNegativeCount}" "${trueNegativePercent}"
printf "number of false negatives:   %5d or %2.1f%%\n" "${falseNegativeCount}" "${falseNegativePercent}"
printf "number of false positives:   %5d or %2.1f%%\n" "${falsePositiveCount}" "${falsePositivePercent}"
printf "number of true  positives:   %5d or %2.1f%%\n" "${truePositiveCount}"  "${truePositivePercent}"

printf "\nGenerating M3U8 playlists  ...\n\n"
csv-to-m3u8.sh test-set-false-negatives.csv
csv-to-m3u8.sh test-set-false-positives.csv
csv-to-m3u8.sh test-set-true-negatives.csv
csv-to-m3u8.sh test-set-true-positives.csv

# Cleanup
rm temp*.csv

