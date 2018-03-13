/*
AD 350 Database Technology Final Project
Due March 23, 2018

Prompt: Using DDL construct the database called AIR_ROUTES. Load the table with 
		the information contained in the .Routes.csv file. Perform the queries below.
*/

-- #1: Using DDL construct the database and table.
CREATE DATABASE IF NOT EXISTS `AIR_ROUTES`;

USE `AIR_ROUTES`;
CREATE TABLE IF NOT EXISTS `Route`
(
	`Airline` CHAR(3) NOT NULL COMMENT 'Two digit code for airport',
	`From_Airport` CHAR(3) NOT NULL COMMENT 'Three letter code for departing airport',
	`To_Airport` CHAR(3) NOT NULL COMMENT 'Three letter code for arrival airport'
)ENGINE INNODB COMMENT 'Table that holds the info for airlines and their flight plans';

-- #2: Load the table with the information contained in the Routes.csv file
LOAD DATA LOCAL INFILE '/Users/daniellecoulter/Desktop/Routes.csv'
	INTO TABLE `Route`
	FIELDS TERMINATED BY ',';
	
-- #3: Add a new table to the database called ROUTE2 indentical to Routes with
-- 		additional column of Miles INT NOT NULL with a default of 0.
DROP TABLE `Route2`;
CREATE TABLE IF NOT EXISTS `Route2` LIKE `Route`;
INSERT `Route2` SELECT * FROM `Route`; -- #4: Move all the data from ROUTE to ROUTE2
ALTER TABLE `Route2`
	ADD COLUMN `Miles` INT NOT NULL DEFAULT 0 COMMENT 'Will hold the distance (in miles) between airports';

-- #5: Display a few rows of ROUTE2 to ensure the data are there and the Miles column has a value of 0
SELECT * 
	FROM `AIR_ROUTES`.`Route2` 
	LIMIT 3; 

-- #6 Alter table ROUTE2 to add a new column: Last_Update DATE with a default of current date
ALTER TABLE `Route2`
	ADD COLUMN `Last_Update` TIMESTAMP NOT NULL DEFAULT NOW(); 

-- #7 Display a few rows of ROUTE2 displays with current date.
SELECT * 
	FROM `Route2`
	LIMIT 3;
