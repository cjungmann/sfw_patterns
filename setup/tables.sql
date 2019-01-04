SET default_storage_engine=InnoDB;

CREATE TABLE IF NOT EXISTS Person
(
   id    INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   fname VARCHAR(20),
   lname VARCHAR(30),
   phone VARCHAR(20),
   email VARCHAR(128)
);

CREATE TABLE IF NOT EXISTS Address
(
   id     INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   street VARCHAR(50),
   city   VARCHAR(30),
   state  VARCHAR(30)
);

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
       ('OH', 'Ohio  Columbus'),
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

