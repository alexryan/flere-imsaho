#!/bin/sh

################################################################################
# Generate a single symmetric data set.
# This data set will subsequently be broken into 3 subsets:
# training, cross-validation and test.
################################################################################

################################################################################
# Convert m3u8 files to csv
################################################################################

cd $FLERE_IMSAHO/data/playlists
m3u8-to-csv.sh arousal_0_valence_neutral.m3u8
m3u8-to-csv.sh arousal_1_valence_sad.m3u8
m3u8-to-csv.sh arousal_1_valence_neutral.m3u8
m3u8-to-csv.sh arousal_1_valence_positive.m3u8
m3u8-to-csv.sh arousal_2_valence_negative.m3u8
m3u8-to-csv.sh arousal_2_valence_positive.m3u8

################################################################################
# Randomize the data
################################################################################

shuf arousal_0_valence_neutral.csv > arousal_0_valence_neutral.shuffled.csv
shuf arousal_1_valence_sad.csv > arousal_1_valence_sad.shuffled.csv
shuf arousal_1_valence_neutral.csv > arousal_1_valence_neutral.shuffled.csv
shuf arousal_1_valence_positive.csv > arousal_1_valence_positive.shuffled.csv
shuf arousal_2_valence_negative.csv > arousal_2_valence_negative.shuffled.csv
shuf arousal_2_valence_positive.csv > arousal_2_valence_positive.shuffled.csv

group1=$(wc -l arousal_0_valence_neutral.shuffled.csv)
echo "group1 = $group1"
group2=$(wc -l arousal_1_valence_sad.shuffled.csv)
echo "group2 = $group2"
group3=$(wc -l arousal_1_valence_neutral.shuffled.csv)
echo "group3 = $group3"
group4=$(wc -l arousal_1_valence_positive.shuffled.csv)
echo "group4 = $group4"
group5=$(wc -l arousal_2_valence_negative.shuffled.csv)
echo "group5 = $group5"
group6=$(wc -l arousal_2_valence_positive.shuffled.csv)
echo "group6 = $group6"

################################################################################
# Sample a subset of a predefined size from each group
################################################################################

head -n 2344 arousal_0_valence_neutral.shuffled.csv > group1.csv
head -n 2344 arousal_1_valence_sad.shuffled.csv > group2.csv
head -n 2344 arousal_1_valence_neutral.shuffled.csv > group3.csv
head -n 2344 arousal_1_valence_positive.shuffled.csv > group4.csv
head -n 4689 arousal_2_valence_negative.shuffled.csv > group5.csv
head -n 4689 arousal_2_valence_positive.shuffled.csv > group6.csv

group1=$(wc -l group1.csv)
echo "group1 = $group1"
group2=$(wc -l group2.csv)
echo "group2 = $group2"
group3=$(wc -l group3.csv)
echo "group3 = $group3"
group4=$(wc -l group4.csv)
echo "group4 = $group4"
group5=$(wc -l group5.csv)
echo "group5 = $group5"
group6=$(wc -l group6.csv)
echo "group6 = $group6"

################################################################################
# Label the data
################################################################################

cat group1.csv group2.csv group3.csv group4.csv > arousal1.csv
cat group5.csv group6.csv > arousal2.csv

arousal1=$(wc -l arousal1.csv)
echo "arousal1 = $arousal1"
arousal2=$(wc -l arousal2.csv)
echo "arousal2 = $arousal2"

sed 's/$/,1/' arousal1.csv > arousal1.withLabels.csv
sed 's/$/,2/' arousal2.csv > arousal2.withLabels.csv


################################################################################
# Merge into one big data file and shuffle
################################################################################

cat arousal1.withLabels.csv arousal2.withLabels.csv > master.csv
shuf master.csv > flere-imsaho.csv

totalNumberOfSamples=$(wc -l flere-imsaho.csv)
echo "totalNumberOfSamples = $totalNumberOfSamples"


#sed 's/$/,1/' arousal_0_valence_neutral.csv > arousal_0_valence_neutral.withLabels.csv
#sed 's/$/,1/' arousal_1_valence_neutral.csv > arousal_1_valence_neutral.withLabels.csv
#sed 's/$/,1/' arousal_1_valence_positive.csv > arousal_1_valence_positive.withLabels.csv
#sed 's/$/,1/' arousal_1_valence_sad.csv > arousal_1_valence_sad.withLabels.csv
#sed 's/$/,2/' arousal_2_valence_negative.csv > arousal_2_valence_negative.withLabels.csv
#sed 's/$/,2/' arousal_2_valence_positive.csv > arousal_2_valence_positive.withLabels.csv


#cat flere-imsaho_1.csv.new flere-imsaho_2.csv.new > flere-imsaho.csv.unshuffled
#shuf flere-imsaho.csv.unshuffled > flere-imsaho.csv

#ls -lF flere-imsaho*.*

#category1Records=$(wc -l flere-imsaho_1.csv)
#category2Records=$(wc -l flere-imsaho_2.csv)
#totalRecords=$(wc -l flere-imsaho.csv)

#echo "category1Records = $category1Records"
#echo "category2Records = $category2Records"
#echo "    totalRecords = $totalRecords"

#echo -e "\nSample:\n"
#head flere-imsaho.csv

# Clean up the intermediary files
#rm flere-imsaho.csv.unshuffled
#rm flere-imsaho_1.csv.new
#rm flere-imsaho_2.csv.new
#rm flere-imsaho_1.csv
#rm flere-imsaho_2.csv

