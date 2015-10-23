use music;

drop table track;
drop table clip;
drop table voter;
drop table vote;


CREATE TABLE track (
  id                       BIGINT  NOT NULL AUTO_INCREMENT,
  name                     VARCHAR(1024),
  low                      SMALLINT NOT NULL,
  high                     SMALLINT NOT NULL,
  percent_low              DOUBLE,
  percent_high             DOUBLE,
  PRIMARY KEY(id)
);

CREATE TABLE clip (
  id                       BIGINT  NOT NULL AUTO_INCREMENT,
  name                     VARCHAR(128),
  probability_low          DOUBLE,
  probability_high         DOUBLE,
  PRIMARY KEY(id),
  UNIQUE(name)
);

CREATE TABLE voter (
  id                       BIGINT  NOT NULL AUTO_INCREMENT,
  name                     VARCHAR(128),
  PRIMARY KEY(id),
  UNIQUE(name)
);


CREATE TABLE vote (
  id                       BIGINT  NOT NULL AUTO_INCREMENT,
  time                     BIGINT  NOT NULL,
  clip1_id                 BIGINT  NOT NULL,
  clip2_id                 BIGINT  NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY (clip1_id) REFERENCES clip(id),
  FOREIGN KEY (clip2_id) REFERENCES clip(id)
);



