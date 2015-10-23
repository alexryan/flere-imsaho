use music;

SET FOREIGN_KEY_CHECKS = 0;

LOAD DATA LOCAL INFILE '/Users/alexryan/alpine/git/flere-imsaho/data/mysql/clean.csv'
  INTO TABLE clip
FIELDS TERMINATED BY ','
ESCAPED BY '"'
IGNORE 1 LINES
(@dummy1, `name`,  @dummy2, @dummy3, `probability_low`, `probability_high`);

show warnings;
