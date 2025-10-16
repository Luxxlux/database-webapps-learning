-- 1. Show the contents of the Users table with the results ordered by username

USE SocialNetwork;
CREATE TABLE Users (
    UserID SERIAL,
    username VARCHAR(20) UNIQUE,
    password VARCHAR(20) NOT NULL,
    email VARCHAR(20) NOT NULL,
    type VARCHAR(20),
    login_date DATE NOT NULL, 
    PRIMARY KEY (UserID)
);

ALTER TABLE Users
MODIFY COLUMN email VARCHAR(100) UNIQUE NOT NULL;

ALTER TABLE Users
MODIFY COLUMN login_date DATE;

INSERT INTO Users(username, password, email, type) 
VALUES ('hadley', 'poodlessmell', 'hadley@awesomedog.com', 'pet');
INSERT INTO Users (username, password, email, type) 
VALUES ('bella', 'fluffypaws', 'bella@meowmail.com', 'pet');

INSERT INTO Users (username, password, email, type) 
VALUES ('charlie', 'woofmaster', 'charlie@doghub.com', 'pet');

INSERT INTO Users (username, password, email, type) 
VALUES ('luna', 'purrfectlife', 'luna@catgram.com', 'pet');

INSERT INTO Users (username, password, email, type) 
VALUES ('max', 'fetchhero', 'max@pawpost.com', 'pet');

INSERT INTO Users (username, password, email, type) 
VALUES ('daisy', 'tailwag99', 'daisy@snoutmail.com', 'pet');

INSERT INTO Users (username, password, email, type) 
VALUES ('milo', 'bonecollector', 'milo@petverse.com', 'pet');

INSERT INTO Users (username, password, email, type) 
VALUES ('coco', 'furballfun', 'coco@pawmail.com', 'pet');

INSERT INTO Users (username, password, email, type) 
VALUES ('rocky', 'goodboy22', 'rocky@dogspace.com', 'pet');

INSERT INTO Users (username, password, email, type) 
VALUES ('nala', 'whiskerqueen', 'nala@meowverse.com', 'pet');

SELECT *
FROM SocialNetwork.Users
ORDER BY username;

SELECT *
FROM `SocialNetwork`.`Users`
WHERE type = 'pet'
ORDER BY username;

USE SocialNetwork;
CREATE TABLE Links (
    link_id SERIAL PRIMARY KEY,
    link_a VARCHAR(20) NOT NULL,
    link_b VARCHAR(20) NOT NULL,
    creation_date DATE NOT NULL,
    FOREIGN KEY (link_a) REFERENCES Users(username),
    FOREIGN KEY (link_b) REFERENCES Users(username)
);

SHOW CREATE TABLE Links;

INSERT INTO `Links` (link_a, link_b, creation_date) 
VALUES 
('bella', 'charlie', '2025-10-03'),
('charlie', 'luna', '2025-10-04'),
('max', 'charlie', '2025-10-05'),
('daisy', 'hadley', '2025-10-06'),
('daisy', 'max', '2025-10-07'),
('milo', 'luna', '2025-10-08'),
('luna', 'daisy', '2025-10-09'),
('max', 'rocky', '2025-10-10');

SHOW CREATE TABLE Users;