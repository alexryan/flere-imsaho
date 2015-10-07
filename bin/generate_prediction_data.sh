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
# Add indices into the matrices.
# This enables us to extract the raw data for each clip.
# We do this when we plot.
################################################################################

nl --body-numbering=a --number-separator=',' training-set-predictions.csv | tr -d " " > training-set-predictions-with-indices.csv
nl --body-numbering=a --number-separator=',' validation-set-predictions.csv | tr -d " " > validation-set-predictions-with-indices.csv
nl --body-numbering=a --number-separator=',' test-set-predictions.csv | tr -d " " > test-set-predictions-with-indices.csv


################################################################################
# Add some headers
# This is necessary to make "csvsort" work properly
################################################################################

cat header.csv | cat - training-set-predictions.csv > /tmp/out && mv /tmp/out training-set-predictions.csv
cat header.csv | cat - validation-set-predictions.csv > /tmp/out && mv /tmp/out validation-set-predictions.csv
cat header.csv | cat - test-set-predictions.csv > /tmp/out && mv /tmp/out test-set-predictions.csv

cat header-with-indices.csv | cat - training-set-predictions-with-indices.csv > /tmp/out && mv /tmp/out training-set-predictions-with-indices.csv
cat header-with-indices.csv | cat - validation-set-predictions-with-indices.csv > /tmp/out && mv /tmp/out validation-set-predictions-with-indices.csv
cat header-with-indices.csv | cat - test-set-predictions-with-indices.csv > /tmp/out && mv /tmp/out test-set-predictions-with-indices.csv

printf "\nheaders added ...\n"

printf "\ntraining-set-predictions.csv:\n"
head -n 3 training-set-predictions.csv

printf "\nvalidation-set-predictions.csv:\n"
head -n 3 validation-set-predictions.csv

printf "\ntest-set-predictions.csv:\n"
head -n 3 test-set-predictions.csv

printf "\ntraining-set-predictions-with-indices.csv:\n"
head -n 3 training-set-predictions-with-indices.csv

printf "\nvalidation-set-predictions-with-indices.csv:\n"
head -n 3 validation-set-predictions-with-indices.csv

printf "\ntest-set-predictions-with-indices.csv:\n"
head -n 3 test-set-predictions-with-indices.csv



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
sed -n ${group2Start},${group2End}p temp-full.csv > training-set-false-positives.csv
sed -n ${group3Start},${group3End}p temp-full.csv > training-set-false-negatives.csv
sed -n ${group4Start},${group4End}p temp-full.csv > training-set-true-positives.csv


# Add the headers
# trainin-gset-true-negatives.csv already has it
cat header.csv | cat - training-set-false-negatives.csv > /tmp/out && mv /tmp/out training-set-false-negatives.csv
cat header.csv | cat - training-set-false-positives.csv > /tmp/out && mv /tmp/out training-set-false-positives.csv
cat header.csv | cat - training-set-true-positives.csv > /tmp/out && mv /tmp/out training-set-true-positives.csv

totalCount1=$(wc -l training-set-predictions.csv | cut -d' ' -f1)
let totalCount1="$totalCount1 - 1"
trueNegativeCount=$(wc -l training-set-true-negatives.csv | cut -d' ' -f1)
let trueNegativeCount="$trueNegativeCount - 1"
falseNegativeCount=$(wc -l training-set-false-negatives.csv | cut -d' ' -f1)
let falseNegativeCount="$falseNegativeCount - 1"
falsePositiveCount=$(wc -l training-set-false-positives.csv | cut -d' ' -f1)
let falsePositiveCount="$falsePositiveCount - 1"
truePositiveCount=$(wc -l training-set-true-positives.csv | cut -d' ' -f1)
let truePositiveCount="$truePositiveCount - 1"

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


################################################################################
# Sort by probability
################################################################################

# Sort true positives by the probility of being positive (in descending order)
csvsort training-set-true-positives.csv -c "prob_of_2" -r  > temp.csv
mv temp.csv training-set-true-positives.csv

# Sort true negatives by the probility of being negative (in descending order)
csvsort training-set-true-negatives.csv -c "prob_of_1" -r  > temp.csv
mv temp.csv training-set-true-negatives.csv

# Sort false positives by the probility of being positive (in descending order)
csvsort training-set-false-positives.csv -c "prob_of_2" -r  > temp.csv
mv temp.csv training-set-false-positives.csv

# Sort false negatives by the probility of being negative (in descending order)
csvsort training-set-false-negatives.csv -c "prob_of_1" -r  > temp.csv
mv temp.csv training-set-false-negatives.csv


printf "\nAre they sorted by probability\?\n"

printf "\ntraining-set-true-positives\n"
head -n 5 training-set-true-positives.csv

printf "\ntraining-set-true-negatives\n"
head -n 5 training-set-true-negatives.csv

printf "\ntraining-set-false-positives\n"
head -n 5 training-set-false-positives.csv

printf "\ntraining-set-false-negatives\n"
head -n 5 training-set-false-negatives.csv


printf "\nGenerating M3U8 playlists  ...\n\n"
csv-to-m3u8.sh training-set-false-negatives.csv
csv-to-m3u8.sh training-set-false-positives.csv
csv-to-m3u8.sh training-set-true-negatives.csv
csv-to-m3u8.sh training-set-true-positives.csv

read -n1 -r -p "Press any key to continue..." key

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
sed -n ${group2Start},${group2End}p temp-full.csv > validation-set-false-positives.csv
sed -n ${group3Start},${group3End}p temp-full.csv > validation-set-false-negatives.csv
sed -n ${group4Start},${group4End}p temp-full.csv > validation-set-true-positives.csv


# Add the headers
# validation-set-true-negatives.csv already has it
cat header.csv | cat - validation-set-false-negatives.csv > /tmp/out && mv /tmp/out validation-set-false-negatives.csv
cat header.csv | cat - validation-set-false-positives.csv > /tmp/out && mv /tmp/out validation-set-false-positives.csv
cat header.csv | cat - validation-set-true-positives.csv > /tmp/out && mv /tmp/out validation-set-true-positives.csv

totalCount1=$(wc -l validation-set-predictions.csv | cut -d' ' -f1)
let totalCount1="$totalCount1 - 1"
trueNegativeCount=$(wc -l validation-set-true-negatives.csv | cut -d' ' -f1)
let trueNegativeCount="$trueNegativeCount - 1"
falseNegativeCount=$(wc -l validation-set-false-negatives.csv | cut -d' ' -f1)
let falseNegativeCount="$falseNegativeCount - 1"
falsePositiveCount=$(wc -l validation-set-false-positives.csv | cut -d' ' -f1)
let falsePositiveCount="$falsePositiveCount - 1"
truePositiveCount=$(wc -l validation-set-true-positives.csv | cut -d' ' -f1)
let truePositiveCount="$truePositiveCount - 1"

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


################################################################################
# Sort by probability
################################################################################

# Sort true positives by the probility of being positive (in descending order)
csvsort validation-set-true-positives.csv -c "prob_of_2" -r  > temp.csv
mv temp.csv validation-set-true-positives.csv

# Sort true negatives by the probility of being negative (in descending order)
csvsort validation-set-true-negatives.csv -c "prob_of_1" -r  > temp.csv
mv temp.csv validation-set-true-negatives.csv
OA
# Sort false positives by the probility of being positive (in descending order)
csvsort validation-set-false-positives.csv -c "prob_of_2" -r  > temp.csv
mv temp.csv validation-set-false-positives.csv

# Sort false negatives by the probility of being negative (in descending order)
csvsort validation-set-false-negatives.csv -c "prob_of_1" -r  > temp.csv
mv temp.csv validation-set-false-negatives.csv


printf "\nAre they sorted by probability\?\n"

printf "\nvalidation-set-true-positives\n"
head -n 5 validation-set-true-positives.csv

printf "\nvalidation-set-true-negatives\n"
head -n 5 validation-set-true-negatives.csv

printf "\nvalidation-set-false-positives\n"
head -n 5 validation-set-false-positives.csv

printf "\nvalidation-set-false-negatives\n"
head -n 5 validation-set-false-negatives.csv



printf "\nGenerating M3U8 playlists  ...\n\n"
csv-to-m3u8.sh validation-set-false-negatives.csv
csv-to-m3u8.sh validation-set-false-positives.csv
csv-to-m3u8.sh validation-set-true-negatives.csv
csv-to-m3u8.sh validation-set-true-positives.csv

read -n1 -r -p "Press any key to continue..." key


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
sed -n ${group2Start},${group2End}p temp-full.csv > test-set-false-positives.csv
sed -n ${group3Start},${group3End}p temp-full.csv > test-set-false-negatives.csv
sed -n ${group4Start},${group4End}p temp-full.csv > test-set-true-positives.csv

# Add the headers
# test-set-true-negatives.csv already has it
cat header.csv | cat - test-set-false-negatives.csv > /tmp/out && mv /tmp/out test-set-false-negatives.csv
cat header.csv | cat - test-set-false-positives.csv > /tmp/out && mv /tmp/out test-set-false-positives.csv
cat header.csv | cat - test-set-true-positives.csv > /tmp/out && mv /tmp/out test-set-true-positives.csv

totalCount1=$(wc -l test-set-predictions.csv | cut -d' ' -f1)
let totalCount1="$totalCount1 - 1"
trueNegativeCount=$(wc -l test-set-true-negatives.csv | cut -d' ' -f1)
let trueNegativeCount="$trueNegativeCount - 1"
falseNegativeCount=$(wc -l test-set-false-negatives.csv | cut -d' ' -f1)
let falseNegativeCount="$falseNegativeCount - 1"
falsePositiveCount=$(wc -l test-set-false-positives.csv | cut -d' ' -f1)
let falsePositiveCount="$falsePositiveCount - 1"
truePositiveCount=$(wc -l test-set-true-positives.csv | cut -d' ' -f1)
let truePositiveCount="$truePositiveCount - 1"

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


################################################################################
# Sort by probability
################################################################################

# Sort true positives by the probility of being positive (in descending order)
csvsort test-set-true-positives.csv -c "prob_of_2" -r  > temp.csv
mv temp.csv test-set-true-positives.csv

# Sort true negatives by the probility of being negative (in descending order)
csvsort test-set-true-negatives.csv -c "prob_of_1" -r  > temp.csv
mv temp.csv test-set-true-negatives.csv

# Sort false positives by the probility of being positive (in descending order)
csvsort test-set-false-positives.csv -c "prob_of_2" -r  > temp.csv
mv temp.csv test-set-false-positives.csv

# Sort false negatives by the probility of being negative (in descending order)
csvsort test-set-false-negatives.csv -c "prob_of_1" -r  > temp.csv
mv temp.csv test-set-false-negatives.csv


printf "\nAre they sorted by probability\?\n"

printf "\ntest-set-true-positives\n"
head -n 5 test-set-true-positives.csv

printf "\ntest-set-true-negatives\n"
head -n 5 test-set-true-negatives.csv

printf "\ntest-set-false-positives\n"
head -n 5 test-set-false-positives.csv

printf "\ntest-set-false-negatives\n"
head -n 5 test-set-false-negatives.csv


printf "\nGenerating M3U8 playlists  ...\n\n"
csv-to-m3u8.sh test-set-true-positives.csv
csv-to-m3u8.sh test-set-true-negatives.csv
csv-to-m3u8.sh test-set-false-positives.csv
csv-to-m3u8.sh test-set-false-negatives.csv

read -n1 -r -p "Press any key to continue..." key



################################################################################
# Test Set: Generate plots
################################################################################

printf "\nGenerating plots for test-set-predictions-with-indices.csv...\n"

# Sort the predictions first by actuals and then by predictions: ((1,1),(1,2),(2,1),(2,2))
csvsort test-set-predictions-with-indices.csv -c 3,4 > temp-full.csv

# Get only the actuals and predictions
# 1,1
# ...
# 1,2
cut -f 3,4 -d , temp-full.csv > temp-short.csv

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

sed -n ${group1Start},${group1End}p temp-full.csv > test-set-true-negatives-with-indices.csv
sed -n ${group2Start},${group2End}p temp-full.csv > test-set-false-positives-with-indices.csv
sed -n ${group3Start},${group3End}p temp-full.csv > test-set-false-negatives-with-indices.csv
sed -n ${group4Start},${group4End}p temp-full.csv > test-set-true-positives-with-indices.csv


# Add the headers
# test-set-true-negatives-with-indices.csv already has it
cat header-with-indices.csv | cat - test-set-false-negatives-with-indices.csv > /tmp/out && mv /tmp/out test-set-false-negatives-with-indices.csv
cat header-with-indices.csv | cat - test-set-false-positives-with-indices.csv > /tmp/out && mv /tmp/out test-set-false-positives-with-indices.csv
cat header-with-indices.csv | cat - test-set-true-positives-with-indices.csv > /tmp/out && mv /tmp/out test-set-true-positives-with-indices.csv


printf "\nValidating ...\n"

totalCount1=$(wc -l test-set-predictions-with-indices.csv | cut -d' ' -f1)
let totalCount1="$totalCount1 - 1"
trueNegativeCount=$(wc -l test-set-true-negatives-with-indices.csv | cut -d' ' -f1)
let trueNegativeCount="$trueNegativeCount - 1"
falseNegativeCount=$(wc -l test-set-false-negatives-with-indices.csv | cut -d' ' -f1)
let falseNegativeCount="$falseNegativeCount - 1"
falsePositiveCount=$(wc -l test-set-false-positives-with-indices.csv | cut -d' ' -f1)
let falsePositiveCount="$falsePositiveCount - 1"
truePositiveCount=$(wc -l test-set-true-positives-with-indices.csv | cut -d' ' -f1)
let truePositiveCount="$truePositiveCount - 1"

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


################################################################################
# Sort by probability
################################################################################

# Sort true positives by the probility of being positive (in descending order)
csvsort test-set-true-positives-with-indices.csv -c "prob_of_2" -r  > temp.csv
mv temp.csv test-set-true-positives-with-indices.csv

# Sort true negatives by the probility of being negative (in descending order)
csvsort test-set-true-negatives-with-indices.csv -c "prob_of_1" -r  > temp.csv
mv temp.csv test-set-true-negatives-with-indices.csv

# Sort false positives by the probility of being positive (in descending order)
csvsort test-set-false-positives-with-indices.csv -c "prob_of_2" -r  > temp.csv
mv temp.csv test-set-false-positives-with-indices.csv

# Sort false negatives by the probility of being negative (in descending order)
csvsort test-set-false-negatives-with-indices.csv -c "prob_of_1" -r  > temp.csv
mv temp.csv test-set-false-negatives-with-indices.csv


printf "\nAre they sorted by probability\?\n"

printf "\ntest-set-true-positives-with-indices\n"
head -n 5 test-set-true-positives-with-indices.csv

printf "\ntest-set-true-negatives-with-indices\n"
head -n 5 test-set-true-negatives-with-indices.csv

printf "\ntest-set-false-positives-with-indices\n"
head -n 5 test-set-false-positives-with-indices.csv

printf "\ntest-set-false-negatives-with-indices\n"
head -n 5 test-set-false-negatives-with-indices.csv


printf "\nGenerating top plot data ...\n"

printf "\nGenerating plots ...\n"

printf "\nGenerating plot documents ...\n"




# Cleanup
rm temp*.csv

