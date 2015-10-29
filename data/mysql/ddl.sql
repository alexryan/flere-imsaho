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

CREATE TABLE user (
  id                       BIGINT  NOT NULL AUTO_INCREMENT,
  facebook_id              BIGINT  NOT NULL,
  facebook_name            VARCHAR(128),
  facebook_email           VARCHAR(128),
  facebook_gender          VARCHAR(128),
  PRIMARY KEY(id),
  UNIQUE(facebook_id),
  UNIQUE(facebook_email)
);

CREATE TABLE vote (
  id                        BIGINT  NOT NULL AUTO_INCREMENT,
  time                      BIGINT  NOT NULL,
  user_id                   BIGINT  NOT NULL,
  clip1_id                  BIGINT  NOT NULL,
  clip2_id                  BIGINT  NOT NULL,
  higher_arousal            SMALLINT NOT NULL,
  higher_valence            SMALLINT NOT NULL,
  higher_arousal_certainty  SMALLINT NOT NULL,
  higher_valence_certainty  SMALLINT NOT NULL,
PRIMARY KEY(id),
  FOREIGN KEY (user_id) REFERENCES user(id),
  FOREIGN KEY (clip1_id) REFERENCES clip(id),
  FOREIGN KEY (clip2_id) REFERENCES clip(id)
);



