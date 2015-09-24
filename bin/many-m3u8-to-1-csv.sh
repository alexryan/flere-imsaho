#!/bin/sh

################################################################################
# Generate $FLERE_IMSAHO/data/audio/experiment.csv
################################################################################

cd $FLERE_IMSAHO/data/audio
m3u8-to-csv.sh flere-imsaho_1.m3u8
m3u8-to-csv.sh flere-imsaho_2.m3u8
sed 's/$/,1/' flere-imsaho_1.csv > flere-imsaho_1.csv.new
sed 's/$/,2/' flere-imsaho_2.csv > flere-imsaho_2.csv.new
cat flere-imsaho_1.csv.new flere-imsaho_2.csv.new > flere-imsaho.csv.unshuffled
shuf flere-imsaho.csv.unshuffled > flere-imsaho.csv

ls -lF flere-imsaho*.*

category1Records=$(wc -l flere-imsaho_1.csv)
category2Records=$(wc -l flere-imsaho_2.csv)
totalRecords=$(wc -l flere-imsaho.csv)

echo "category1Records = $category1Records"
echo "category2Records = $category2Records"
echo "    totalRecords = $totalRecords"

echo -e "\nSample:\n"
head flere-imsaho.csv

# Clean up the intermediary files
rm flere-imsaho.csv.unshuffled
rm flere-imsaho_1.csv.new
rm flere-imsaho_2.csv.new
rm flere-imsaho_1.csv
rm flere-imsaho_2.csv

