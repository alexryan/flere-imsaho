use music;

drop table track;

CREATE TABLE track (
  id                       BIGINT  NOT NULL AUTO_INCREMENT,
  name                     VARCHAR(1024),
  low                      SMALLINT NOT NULL,
  high                     SMALLINT NOT NULL,
  percent_low              DOUBLE,
  percent_high             DOUBLE,
  PRIMARY KEY(id)
);

