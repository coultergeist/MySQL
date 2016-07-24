/*
PROPOSAL: SECTION 4: TEST DATA
	FROM: The Best Co. 
	TO: "Date-A-Base, L.L.C. 
Purpose: Confirm usability, performance, design, and to run unit tests.
Database Administrator: Danielle Coulter, Employee ID: 89456. Seattle, WA.
Database created: June 15, 2016
*/




----------------------------------------------------------------------
-- Insert test data into `User` table
INSERT INTO `User` (`Uuid_User`, `First_Name`, `Last_Name`, `Date_Of_Birth`, `User_Email`, `User_Password`, `Latitude`, `Longitude`) VALUES 
	(Uuid_To_Binary(UUID()), 'Jeffery', 'Lebowski', '12-04-1940', 'thedudeabides@gmail.com', 'password', '33.9850', '118.4695'),
	(Uuid_To_Binary(UUID()), 'Walter', 'Sobchak', '08-20-1939', 'vietnamvet@gmail.com', 'shomershabbas', '34.0928', '118.3287'),
	(Uuid_To_Binary(UUID()), 'Maude', 'Lebowski', '04-11-1942', 'stronglyvaginal@yahoo.com', 'lebowskifoundation' '34.1870', '118.3813');


	
-- Insert test data into `Photograph` table
INSERT INTO `Photograph` (`Uuid_Photograph`, `ID_User`, `Primary`, `Photograph_Name`, `Photograph_Caption`) VALUES 
	(Uuid_To_Binary(UUID()), '44', 'Me', 'Donnies Funeral', 'Walter and I'),
	(Uuid_To_Binary(UUID()), '42', 'Walter', '1988SemiFinals', 'Winners!'),
	(Uuid_To_Binary(UUID()), '39', 'MaudeLebowski', 'Painting', 'TheFemaleForm');
	
	

-- Insert test data into `Config_Questions` table
INSERT INTO `Config_Questions` (`Question_Code`, `Text_Question`, `Required`, `Reference_Table`) VALUES
	('Gender', 'What is your Gender?', '1', 'Reference_Gender'),
	('Hair_Color', 'What color is your hair?', '0', 'Reference_Hair_Color'),
	('Race', 'What is your Race', '0', 'Reference_Race'),
	('Birthdate', 'What is your birthdate?', '0', NULL),
	('Pets', 'Do you have any pets?', '0', NULL);

		
	
-- 	Insert test data into `Personal_Answers` table
INSERT INTO `Personal_Answers` (`Uuid_Answer`, `ID_User`, `Question_Code`, `Personal_Answers`) VALUES
	(Uuid_To_Binary(UUID()), '3', '4', '1'),
	(Uuid_To_Binary(UUID()), '4', '6', 'RD'),
	(Uuid_To_Binary(UUID()), '5', '3', 'R5');
	

	
-- Insert test data into `Preference` table
INSERT INTO `Preference` (`ID_User`, `Question_Code`, `Preference_Answer`) VALUES
	('1', 'Gender', 'Male'),	
	('1', 'Ethnicity', 'Russian'),
	('1', 'Race', 'White/Caucasian'),
	('5', 'Gender', 'Female'),
	('5', 'Age_Band', '18-25');
	

-- 	Insert test data into `Messages`` table
INSERT INTO `Messages`` (`Uuid_User`, `ID_User_Sender`, `ID_User_Receiver`, `Message_Subject`, `Message_Body`, `Date_Sent`) VALUES
	(Uuid_To_Binary(UUID()), '3', '10', '!?!?', 'What are we going to tell Lebowski? They are going to kill that poor girl.', '03-06-1988'),
	(Uuid_To_Binary(UUID()), '10', '3', 'Relax Dude', 'She probably kidnapped herself.', '03-07-1988'),
	(Uuid_To_Binary(UUID()), '5', '3', 'Im emailing about my rug.', 'Please call me.', '03-09-1988');
	
	
	

-- Insert test data into `Block` table
INSERT INTO `Block` (`ID_User_Blocker`, `ID_User_Blockee`) VALUES
	('10', '3'),
	('5', '3'),
	('9', '3');
