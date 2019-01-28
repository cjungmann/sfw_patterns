SET default_storage_engine=InnoDB;

CREATE TABLE IF NOT EXISTS Address
(
   id     INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   zone   ENUM('residential','commercial','industrial','agricultural','rural','combination','historic','aesthetic'),
   street VARCHAR(50),
   city   VARCHAR(30),
   state  VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS Keyword
(
   id    INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   value VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS Keyword2Address
(
   id_keyword INT UNSIGNED,
   id_address INT UNSIGNED,
   INDEX(id_keyword),
   INDEX(id_address)
);

CREATE TABLE IF NOT EXISTS Feature
(
   id    INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   value VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS Feature2Address
(
   id_feature INT UNSIGNED,
   id_address INT UNSIGNED,
   position   TINYINT UNSIGNED,
   INDEX(id_feature),
   INDEX(id_address)
);

-- We only want a single set of states,
-- so drop, recreate, and repopulate.
DROP TABLE IF EXISTS State;
CREATE TABLE IF NOT EXISTS State
(
   id           INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   name         VARCHAR(30),
   abbreviation CHAR(2)
);


INSERT INTO State (abbreviation, name)
VALUES ('AL', 'Alabama'),
       ('AK', 'Alaska'),
       ('AZ', 'Arizona'),
       ('AR', 'Arkansas'),
       ('CA', 'California'),
       ('CO', 'Colorado'),
       ('CT', 'Connecticut'),
       ('DE', 'Delaware'),
       ('FL', 'Florida'),
       ('GA', 'Georgia'),
       ('HI', 'Hawaii'),
       ('ID', 'Idaho'),
       ('IL', 'Illinois'),
       ('IN', 'Indiana'),
       ('IA', 'Iowa'),
       ('KS', 'Kansas'),
       ('KY', 'Kentucky'),
       ('LA', 'Louisiana'),
       ('ME', 'Maine'),
       ('MD', 'Maryland'),
       ('MA', 'Massachusetts'),
       ('MI', 'Michigan'),
       ('MN', 'Minnesota'),
       ('MS', 'Mississippi'),
       ('MO', 'Missouri'),
       ('MT', 'Montana'),
       ('NE', 'Nebraska'),
       ('NV', 'Nevada'),
       ('NH', 'New Hampshire'),
       ('NJ', 'New Jersey'),
       ('NM', 'New Mexico'),
       ('NY', 'New York'),
       ('NC', 'North Carolina'),
       ('ND', 'North Dakota'),
       ('OH', 'Ohio'),
       ('OK', 'Oklahoma'),
       ('OR', 'Oregon'),
       ('PA', 'Pennsylvania'),
       ('RI', 'Rhode Island'),
       ('SC', 'South Carolina'),
       ('SD', 'South Dakota'),
       ('TN', 'Tennessee'),
       ('TX', 'Texas'),
       ('UT', 'Utah'),
       ('VT', 'Vermont'),
       ('VA', 'Virginia'),
       ('WA', 'Washington'),
       ('WV', 'West Virginia'),
       ('WI', 'Wisconsin'),
       ('WY', 'Wyoming');

