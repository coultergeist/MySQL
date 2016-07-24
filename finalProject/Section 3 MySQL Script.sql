/*
PROPOSAL: SECTION 3: SQL SCRIPT
	FROM: The Best Co. 
	TO: "Date-A-Base, L.L.C. 
Purpose: Designing the Tables, Relationships and Reference Tables
Database needs: Store User information, send messages, block/save other users, upload photographs, etc. 
IMPORTANT: Security is a major concern here so not all information will be visible by everyone.
Database Administrator: Danielle Coulter, Employee ID: 89456. Seattle, WA.
Database created: June 15, 2016
*/




----------------------------------------------------------------------
-- Create table for User to provide public information, visible by all users
CREATE TABLE IF NOT EXISTS `User`
(
	`ID_User` BIGINT(16) NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Private Unique indentifier for each user',  
	`Uuid_User` BINARY(16) NOT NULL COMMENT 'Public identifier for users',
	`First_Name` VARCHAR(255) NOT NULL COMMENT 'Users last name',
	`Last_Name` VARCHAR(255) NOT NULL COMMENT 'Users last name',
	`Date_Of_Birth` DATE NOT NULL COMMENT 'User DOB',
	`User_Email` VARCHAR(50) NOT NULL COMMENT 'Users email address',
	`User_Password` VARCHAR(255) NOT NULL COMMENT 'Users login password',
	`Latitude` DECIMAL(8,6) NOT NULL COMMENT 'Part 1 of 2 for lacation',
	`Longitude` DECIMAL(9,6) NOT NULL COMMENT 'Part 2 of 2 for lacation'
)ENGINE INNODB COMMENT 'The information of all users on Date-A-Base';




-- Create table for users to store profile photos
CREATE TABLE IF NOT EXISTS `Photograph`
(
	`ID_Photograph` TINYINT(3) NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique indentifier of users photo',
	`Uuid_Photograph` BINARY(16) NOT NULL COMMENT 'Photo indentifier ',
	`ID_User` BIGINT(16) NOT NULL COMMENT 'Private Unique indentifier for each user', 
	`Primary` TINYINT(1) NOT NULL COMMENT 'The users primary profile photo',
	`Photograph_Name` VARCHAR(50) NULL COMMENT 'all other (optional) photos of a user',
	`Photograph_Caption` VARCHAR(45) NULL COMMENT 'Description of how great her weekend to Tiajana was'
)ENGINE INNODB COMMENT 'The photographs of all users on Date-A-Base';


-- Relate the `Photograph` table to the `User` table through the constraint of a Foreign Key
ALTER TABLE `Photograph`
	ADD CONSTRAINT `FK_Photograph_User`
	FOREIGN KEY (`ID_User`)
	REFERENCES `User` (`ID_User`);
	
	
	
	
-- Configuration table created to allow each person to answer questions	
CREATE TABLE IF NOT EXISTS `Config_Questions`
(	
	`ID_Question` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for each stored question',
	`Question_Code` VARCHAR(25) NOT NULL COMMENT 'Code indentifier for each question',
	`Text_Question` VARCHAR(25) NOT NULL COMMENT 'What kind of peanut butter does your dog like?', 
	`Required` TINYINT(1) NOT NULL DEFAULT '0' COMMENT 'This questions may/may not be required',
	`Reference_Table` VARCHAR(50) DEFAULT NULL COMMENT'If the question is required it will take you to the applicable reference table to answer the question'
)ENGINE INNODB COMMENT 'This is a list of all possible questions a user can choose to answer though not required';	
	
	
	
	
	
-- Create table to store Personal Answers to mandatory & optional questions
CREATE TABLE IF NOT EXISTS `Personal_Answers`
(
	`ID_Answer` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique indentifier for each question answered',  
	`Uuid_Answer` BINARY(16) NOT NULL COMMENT 'Unique indentifier for each answer given',
	`ID_User` BIGINT(16) NOT NULL COMMENT 'Private Unique indentifier for each user',
	`Question_Code` VARCHAR(25) NOT NULL COMMENT 'Code indentifier for each question',
	`Personal_Answers` VARCHAR(255) NOT NULL COMMENT 'Answers to questions'
)ENGINE INNODB COMMENT 'The answers each users on Date-A-Base';


-- Relate the `Personal_Answers` table to the `User` table through the constraint of a Foreign Key
ALTER TABLE `Personal_Answers`
	ADD CONSTRAINT `FK_PersonalAnswers_User`
	FOREIGN KEY (`ID_User`)
	REFERENCES `User` (`ID_User`);

	
	
	
-- Create table for users to store preferences (other users/qualities they prefer)
CREATE TABLE IF NOT EXISTS `Preference`
(
	`ID_Preference` TINYINT(3) NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique indentifier of users photo',
	`ID_User` BIGINT(16) NOT NULL COMMENT 'Private Unique indentifier for each user',  
	`Question_Code` VARCHAR(25) NOT NULL COMMENT 'Code indentifier for each question',
	`Preference_Answer` VARCHAR(255) NOT NULL COMMENT 'Responses that users prefer a mate to answer the questions'
)ENGINE INNODB COMMENT 'These are the preferences set by users on Date-A-Base';


-- Relate the `Preference` table to the `User` table through the constraint of a Foreign Key
ALTER TABLE `Preference`
	ADD CONSTRAINT `FK_Preference_User`
	FOREIGN KEY (`ID_User`)
	REFERENCES `User` (`ID_User`);
	
	
-- Relate the `Preference` table to the `Personal_Answers` table through the constraint of a Foreign Key
ALTER TABLE `Preference`
	ADD CONSTRAINT `FK_Preference_PersonalAnswers`
	FOREIGN KEY (`Question_Code`)
	REFERENCES `Personal_Answers` (`Question_Code`);	
	
	
	
	
-- Create table for users to communicate with other users via private messages
CREATE TABLE IF NOT EXISTS `Messages`
(
	`ID_Message` INTEGER(11) NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique indentifier of each message',
	`Uuid_Message` BINARY(16) NOT NULL COMMENT 'Unique indentifier for message sent',
	`ID_User_Sender` BIGINT(16) NOT NULL 'Unique indentifier of each person sending a message',
	`ID_User_Receiver` BIGINT(16) NOT NULL 'Unique indentifier of each person receiving a message',
	`Message_Subject` TEXT NOT NULL 'Contents of each message',
	`Message_Body` TEXT NOT NULL 'Contents of each message',
	`Date_Sent` DATETIME NOT NULL 'Date and time the message was created'
)ENGINE INNODB COMMENT 'These are messages of all users on Date-A-Base';


-- Relate the `Messages` table to the `User` table through the constraint of a Foreign Key
ALTER TABLE `Messages`
	ADD CONSTRAINT `FK_Messages_User`
	FOREIGN KEY (`ID_User_Sender`)
	REFERENCES `User` (`ID_User`);
	

-- Relate the `Messages` table to the `User` table through the constraint of a Foreign Key
ALTER TABLE `Messages`
	ADD CONSTRAINT `FK_Messages_User`
	FOREIGN KEY (`ID_User_Receiver`)
	REFERENCES `User` (`ID_User`);	
	
	
	
	
-- Create table for users to block users from communication, viewing their profile/photos, etc.
CREATE TABLE IF NOT EXISTS `Block`
(
	`ID_Block` INTEGER(11) NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique indentifier of each user blocked',
	`ID_User_Blocker` BIGINT(16) NOT NULL 'Unique indentifier of each person doing the blocking',
	`ID_User_Blockee` BIGINT(16) NOT NULL 'Unique indentifier of each person being blocked'
)ENGINE INNODB COMMENT 'This all persons blocked and those who have blocked on Date-A-Base';


-- Relate the `Block` table to the `User` table through the constraint of a Foreign Key
ALTER TABLE `Block`
	ADD CONSTRAINT `FK_Blockee_User`
	FOREIGN KEY (`ID_User_Blockee`)
	REFERENCES `User` (`ID_User`);
	
	
-- Relate the `Block` table to the `User` table through the constraint of a Foreign Key
ALTER TABLE `Block`
	ADD CONSTRAINT `FK_Blocker_User`
	FOREIGN KEY (`ID_User_Blocker`)
	REFERENCES `User` (`ID_User`);	
	
	
	
	
-- -----------------------------------------------------------------------------
-- REFERENCE TABLES:




-- Create Reference table 2.1: Gender. Source: ISO 5218
CREATE TABLE IF NOT EXISTS `Reference_Gender`
(
	`Gender_Code` TINYINT(1) NOT NULL PRIMARY KEY COMMENT 'Codes of genders',
	`Comment` VARCHAR(255) NOT NULL REFERENCES `Config_Questions` (`ID_Question`)'Description of Gender'
)ENGINE INNODB COMMENT 'List of all genders allowed';


-- Insert Test Data into Gender Reference table 
INSERT INTO `Reference_Gender` (`Gender_Code`, `Comment`) VALUES 
	('0', 'NotKnown'),
	('1', 'Male') ,
	('2', 'Female'), 
	('9', 'NotApplicable') ;
		
	

-- Create Reference table 2.2: Income. Source: The Best Co., RFT19
CREATE TABLE IF NOT EXISTS `Reference_Income_Band`
(
	`Income_Code` TINYINT(1) NOT NULL PRIMARY KEY COMMENT 'Codes of income bands',
	`Comment` VARCHAR(255) NOT NULL REFERENCES `Config_Questions` (`ID_Question`)'Description of Incomes'
)ENGINE INNODB COMMENT 'List of all income bands allowed';


-- Insert Test Data into Income Reference table 
INSERT INTO `Reference_Income_Band` (`Income_Code`, `Comment`) VALUES 
	('NOT', 'Unemployed'),
	('HOME', 'Stay-at-homeJob'),
	('DIS', 'Disabled'),
	('RET', 'Retired'),
	('SCH', 'School'),
	('-15000', '<$15,000'),
	('15000+', '$15,000-$20,000'),
	('20000+', '$20,000-$30,000'),
	('30000+', '$30,000-$40,000'),
	('40000+', '$40,000-$50,000'),
	('50000+', '$50,000-$60,000'),
	('60000+', '$60,000-$70,000'),
	('70000+', '$70,000-$80,000'),
	('80000+', '$80,000-$90,000'),
	('90000+', '$80,000-$90,000'),
	('100000+', '$100,000-$150,000'),
	('150000+', '$150,000-$200,000'),
	('200000+', '>$200,000');


	
	
	
-- Create Reference table 2.3: Age. Source: The Best Co., RFT11
CREATE TABLE IF NOT EXISTS `Reference_Age_Band`
(	
	`Age_Code` TINYINT(1) NOT NULL PRIMARY KEY COMMENT 'Codes of age bands',
	`Comment` VARCHAR(255) NOT NULL REFERENCES `Config_Questions` (`ID_Question`)'Description of Ages'
)ENGINE INNODB COMMENT 'List of all age bands allowed';
		

-- Insert Test Data into Age Reference table 
INSERT INTO `Reference_Age_Band` (`Age_Code`, `Comment`) VALUES 
	('1', '18-25'),
	('2', '26-30'),
	('3', '31-35'),
	('4', '36-40'),
	('5', '41-45'),
	('6', '46-50'),
	('7', '51-55'),
	('8', '56-60'),
	('9', '61-65'),
	('10', '66-70'),
	('11', '71-75'),
	('12', '75+');

	
	
	
-- Create Reference table 2.4: Hair Color. Source: The Best Co., RFT32
CREATE TABLE IF NOT EXISTS `Reference_Hair_Color`
(	
	`Hair_Code` TINYINT(1) NOT NULL PRIMARY KEY COMMENT 'Codes of hair colors',
	`Comment` VARCHAR(255) NOT NULL REFERENCES `Config_Questions` (`ID_Question`)'Description of Hair Color'
)ENGINE INNODB COMMENT 'List of all hair colors allowed';
		

-- Insert Test Data into Hair Color Reference table 
INSERT INTO `Reference_Hair_Color` (`Hair_Code`, `Comment`) VALUES 
	('BD', 'Bald'),
	('BK', 'Black'),
	('BL', 'Blonde'),
	('BR', 'Brunette'),
	('GY', 'Grey'),
	('RD', 'Red'),
	('WH', 'White');
	

	
	
	
-- Create Reference table 2.5: Eye Color. Source: The Best Co., RFT35
CREATE TABLE IF NOT EXISTS `Reference_Eye_Color`
(
	`Eye_Code` TINYINT(1) NOT NULL PRIMARY KEY COMMENT 'Codes of eye colors',
	`Comment` VARCHAR(255) NOT NULL REFERENCES `Config_Questions` (`ID_Question`)'Description of eye Color'
)ENGINE INNODB COMMENT 'List of all eye colors allowed';
		

-- Insert Test Data into Eye Color Reference table 
INSERT INTO `Reference_Eye_Color` (`Eye_Color`, `Comment`) VALUES 	
	('AM', 'Amber'),
	('BL', 'Blue'),
	('BR', 'Brown'),
	('GR', 'Green'),
	('GY', 'Grey'),
	('RV', 'Red&Violet'),
	('SP', 'Spectrum');
	
	
	
	
-- Create Reference table 2.6: Occupation. Source: The Best Co., RFT42
CREATE TABLE IF NOT EXISTS `Reference_Occupation`
(
	`Occupation_Code` CHAR(4) NOT NULL PRIMARY KEY COMMENT 'Codes of occupations',
	`Comment` VARCHAR(255) NOT NULL REFERENCES `Config_Questions` (`ID_Question`)'Description of Occupations'
)ENGINE INNODB COMMENT 'List of all occupations allowed';
		

-- Insert Test Data into Occupation Reference table 
INSERT INTO `Reference_Occupation` (`Occupation_Code`, `Comment`) VALUES 
	('0110', 'ArmedForces'),
	('5131', 'ChildCare'),
	('1223', 'Construction'),
	('0002', 'Entrepreneur'),
	('2221', 'Environmentalist'),
	('2419', 'FinancialServices'),
	('2251', 'Medical'),
	('2229', 'MentalHealth'),
	('0003', 'Philanthropist'),
	('0008', 'Retired'),
	('3145', 'Sales'),
	('5414', 'Security'),
	('1317', 'ServiceIndustry'),
	('2446', 'SocialPrograms'),
	('0001', 'Stay-at-homeJob'),
	('2331', 'Teacher'),
	('7243', 'Technology'),
	('2212', 'Veterinarian');
	
	
	
	     
-- Create Reference table 2.7: Race. Source: Agency for Healthcare Research & Quality
CREATE TABLE IF NOT EXISTS `Reference_Race`
(
	`Race_Code` CHAR(3) NOT NULL PRIMARY KEY COMMENT 'Codes of races',
	`Comment` VARCHAR(255) NOT NULL REFERENCES `Config_Questions` (`ID_Question`)'Description of Race'
)ENGINE INNODB COMMENT 'List of all races allowed';
		

-- Insert Test Data into Race Reference table 
INSERT INTO `Reference_Race` (`Race_Code`, `Comment`) VALUES 
	('R1', 'AmericanIndianorAlaskanative'),
	('R2', 'Asian'),
	('R3', 'BlackorAfricanAmerican'),
	('E1', 'HispanicorLatino'),
	('R4', 'NativeHawaiianorOtherPacificIslander'),
	('R5', 'White/Caucasian'),
	('R9', 'OtherRace'),
	('RZ', 'Unknown/NotProvided');
	

		

-- Create Reference table 2.8: Ethnicity. Source: Agency for Healthcare Research & Quality
CREATE TABLE IF NOT EXISTS `Reference_Ethnicity`
(
	`Ethnicity_Code` CHAR(6) NOT NULL PRIMARY KEY COMMENT 'Codes of ethnicities',
	`Comment` VARCHAR(255) NOT NULL REFERENCES `Config_Questions` (`ID_Question`)'Description of Ethnicity'
)ENGINE INNODB COMMENT 'List of all ethnicities allowed';
		

-- Insert Test Data into Ethnicity Reference table 
INSERT INTO `Reference_Ethnicity` (`Ethnicity_Code`, `Comment`) VALUES 
	('20586', 'AfricanAmerican'),
	('00017', 'American'),
	('21295', 'Arab'),
	('20297', 'AsianIndian'),
	('20560', 'Black'),
	('20347', 'Chinese'),
	('21089', 'European'),
	('20362', 'Filipino'),
	('21352', 'Hispanic/Latino'),
	('21212', 'Iranian'),
	('20412', 'Laotian'),
	('21772', 'LatinAmerican'),
	('24185', 'Mexican'),
	('RZ', 'NotProvided'),
	('00016', 'Russian'),
	('20479', 'Vietnamese');