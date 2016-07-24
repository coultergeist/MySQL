-/*
PROPOSAL: SECTION 5: USE CASES
	FROM: The Best Co. 
	TO: "Date-A-Base, L.L.C.
Purpose: identify and describe capabilities of each user.
	#1: User (plain) 
	#2 Administrator
	
! For all info deleted by Users, data is saved for posterity and accessible by Administrators.	
Database Administrator: Danielle Coulter, Employee ID: 89456. Seattle, WA.
Database created: June 15, 2016
*/




----------------------------------------------------------------------
-- Section 5.1 User Capabilities: Profile Information

-- #1: User wants to register
INSERT INTO `User` (`Uuid_User`, `First_Name`, `Last_Name`, `Date_Of_Birth`, `User_Email`, `User_Password`, `Latitude`, `Longitude`) VALUES 
	('1151', 'Jeffery', 'Lebowski', '12-04-1940', 'thedudeabides@gmail.com', 'password', '33.9850', '118.4695');

INSERT INTO `Personal_Answers` (`Uuid_Answer`, `ID_User`, `Question_Code`, `Personal_Answers`) VALUES
	(Uuid_To_Binary(UUID()), '5', 'Gender_Code', '0'),
	(Uuid_To_Binary(UUID()), '10', 'Race_Code', 'E1'),
	(Uuid_To_Binary(UUID()), '8', 'Ethnicity_Code', '20412'),; 

	
-- #2: User want to add a Profile Pic 
INSERT INTO `Photograph` (`Uuid_Photograph`, `ID_User`, `Photograph_Name`, `Photograph_Caption`, `Primary`)
	VALUES ('124599', '3', 'Donnies Funeral', 'Walter and I', 'Primary')	

	
	
-- #3: User wants to update their photographs
UPDATE `Photograph`
	SET `Photograph_Name`='Bahamas2004.jpg',
	AND `Photograph_Caption`='The best way to celebrate Donnys life',
	WHERE `Uuid_Photograph`='124599',
	AND `User_Id`='3';

	
	
-- #4: User wants to delete a photo from his album
DELETE FROM `Photograph`
	WHERE `ID_Photograph`=`3`	
	
	
	
-- #5: User wants to update his profile, specifically his email
UPDATE `User`
	SET `User_Email`=`restinpeacedonnie@gmail.com,
	WHERE `User_Email`=`thedudeabides@gmail`;
	
	

-- #6: User wants to delete their profile because they have found a relationship
DELETE FROM `User`, 
	WHERE `ID_User`=`3`;	
DELETE FROM `Photograph` 
	WHERE `ID_User`=`3`;
DELETE FROM `Personal_Answers` 
	WHERE IDuser=`3`;
DELETE FROM `Preferences` 
	WHERE `ID_User`=`3`;
DELETE FROM `Block` 
	WHERE `ID_User_Blockee`=`3` OR `ID_User_Blocker`=`3`;
DELETE FROM `Messages` 
	WHERE `ID_User_Sender`=`3` OR `ID_User_Receiver`=`3`;
	
	
	
----------------------------------------------------------------------
-- Section 5.2 User Capabilities: Messaging

-- #7: User wants to create a private message a potential interest
SELECT FROM `Block` 
	WHERE `ID_User_Blockee`!=`5` AND `ID_User_Blocker`!=`5`
INSERT INTO `Messages` (`Uuid_Message`, `ID_User_Sender`, `ID_User_Receiver`, `Message_Description`, `Date_Published`) VALUES 
(Uuid_To_Binary(UUID()), '5', '8', 'Hey', '2016-05-26 11:27:55')
	

	
-- #8: User wants to read their messages from a match they are interested, User 10, Walter 
SELECT *
	FROM `Messages`
	WHERE `ID_User_Sender`=`10`
	
	
	
-- #9: User wants to clean out their message Inbox
DELETE * 
	FROM `Messages`
	WHERE `ID_User_Receiver`=`ID_User`

	

	
----------------------------------------------------------------------
-- Section 5.3 User Capabilities: Creating Preferences	

-- #10: User wants to create preferences for possible matches
INSERT INTO `Preferences` (`ID_User`, `Question_Code`, `Preference_Answers`) VALUES
('5', 'Gender_Code', 'Male')


	
	
-- #11: User wants to change preferences for possible matches
UPDATE `Preferences` 
	SET	`Preference_Answers`='Female'
	WHERE `ID_User`='5' AND `Question_Code`='Gender_Code';
 

		
----------------------------------------------------------------------	
-- Section: 5.4 User Capabilities: Searching for Matches

-- #12: User wants view the profiles of all men with their profile information (including their profile picture, Name, DOB, Location, and answers to any optional profile questions they chose to answer). Also, ensure that I can view anyone that I have not been blocked by and anyone who I have not blocked.
	
SELECT `ID_User` 
	FROM `User` 
	JOIN `Block` 
	ON `Block`.`ID_User`=`User`.`ID_User`
	WHERE `Gender_Code`=`1` AND WHERE `ID_User_Blockee` !=`3` AND `ID_User_Blocker` !=`3`;
SELECT `User` (`Uuid_User`, `First_Name`, `Last_Name`, `Date_Of_Birth`, `User_Email`, `Latitude`, `Longitude`) 
SELECT `Photograph` (`Uuid_Photograph`, `ID_User`, `Photograph_Name`, `Photograph_Caption`, `Primary`);




----------------------------------------------------------------------
-- Section: 5.5 User Capabilities: Blocking
	
--#13: User wants to block a user who has been harassing them
INSERT INTO `Block` (`ID_Block`, `ID_User_Blockee`, `ID_User_Blockee`)	
	VALUES ('1544', '8', '8')	
		

		
-- #14: User wants to unblock someone
DELETE FROM `Block` 
	WHERE `ID_User_Blocker`=`3` AND `ID_User_Blockee`=`5`; 

		
		
----------------------------------------------------------------------	
-- Section: 5.6 Administrator Capabilities:
	
-- #15: Administrator wants to see how many users are signed up on the database
SELECT COUNT(*)
	FROM `User`;
	
	
	
-- #16: Administrator wants to delete a user who has continuously been a problem
DELETE FROM `User`
	WHERE `User`=`3`, `Messages`, `Photograph`, `Preferences`, `Personal_Answers` VALUES
	
DELIMITER $$
CREATE TRIGGER `Delete_User`
BEFORE DELETE ON `User` FOR EACH ROW

BEGIN
	DELETE FROM `Photograph` 
		WHERE `ID_User`=`OLD`.`ID_User`;
	DELETE FROM `Personal_Answers` 
		WHERE `ID_User`=`OLD`.`ID_User`;
	DELETE FROM `Preferences` 
		WHERE `ID_User`=`OLD`.`ID_User`;
	DELETE FROM `Block` 
		WHERE `ID_User_Blocker`=`OLD`.`ID_User` OR `ID_User_Blockee`=`OLD`.`ID_User`;
	DELETE FROM `Messages` 
		WHERE `ID_User_Sender`=`OLD.`ID_User` OR `ID_User_Receiver`=`OLD`.`ID_User`;
END $$

DELIMITER ;	
	
	

-- #17: Administrator wants to add a question to the list of optional profile questions	
INSERT INTO `Config_Questions` (`Question_Code`, `Text_Question`, `Required`, `Reference_Table`) VALUES
	('Education_Code', 'What is your highest level of education?', '1', 'Reference_Education');
	


-- #18: Administrator wants to know what questions are most commonly answered by Men vs. Women
SELECT AVG(`Question_Code`)
    FROM `Config_Questions`, 
	GROUP BY: `Gender_Code`;	
	
	
	
-- #19: Administrator wants to perform a backup of the database: to delete, recreate, and repopulate the each of the tables associated with the database (via command line)
	mysqldump --user=DatabaseAdmin --password=nine 4 four fore --host=172.31.22.68 > Database.sql
    	
	
	
-- #20: Administrator wants to restore the database from a backup
	-- Option 1: From Importing a backup
	mysql --user=DatabaseAdmin --password=nine 4 four fore wikidb < Databasedump.sql
	
	-- Option 2: Restoring from a backup
	mysql -DatabaseAdmin -nine 4 four fore < db_backup.dump USE <Databasedump.sql>;