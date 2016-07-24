/*
PROPOSAL: SECTION 6: EXTRA CREDIT
	FROM: The Best Co. 
	TO: "Date-A-Base, L.L.C.
Database Administrator: Danielle Coulter, Employee ID: 89456. Seattle, WA.
Database created: June 15, 2016
*/




----------------------------------------------------------------------
-- Section 6.1 Use Cases for how users will search for a Match
/*Process of searching for a match:
USER:
-CREATE PROFILE
-UPDATE PROFILE (ADD/DELETE/UPDATE:PHOTOS, EMAIL, LOCATION, ETC.)
-SEARCH PROFILES THAT DO NOT INCLUDE BLOCKED USERS
-SEARCH PROFILES THAT USER IS NOT BLOCKED BY
-VIEW OTHERS PROFILES
-NOTIFY USER OF NEW MESSAGE
-NOTIFY USER WHEN THEIR PROFILE IS VIEWED
-NOTIFY USER WHEN THIER PROFILE IS LIKED
-MESSAGE USER THAT DO NOT INCLUDE BLOCKED USERS
-MESSAGE USER THAT I AM NOT BLOCKED BY
-BLOCK USER
-REMOVE BLOCK ON A USER
-NOTIFY ADMIN OF SUSPECIOUS USERS
-REQUEST HELP FROM ADMIN
-DELETE A HELP CLAIM TO ADMIN
-UPDATE PHOTO
-Select "Search" function
-Enter criteria for which you would like a match to have:
-Mandatory Selection: Gender
-Optional Selections: Income, Age, Hair Color, Eye Color, Occupation, Race, Ethnicity
-Submit criteria
-Select/click user you're interested interested
-View profile of possible match: 
	-View users photo(s)
	-View details of the mandatory questions (Full Name, Date of Birth)
	-View location: Latitude and Longitude
	-Read their answers to optional questions (Race, Income, Eye Color, etc.)
10-If the match looks promising, message user
11-If the match is creepy, block user

--Administrator 	
-DELETE USERS
-EDIT QUESTIONS
-RESPOND TO USERS QUESTIONS
-NOTIFY USERS OF UPCOMING BILL
-NOTIFY USERS THAT PAYMENT WAS RECEIVED
-NOTIFY USER THAT THEIR PROFILE WAS DELETED
-NOTIFY USER THAT PAYMENT INFORMATION WAS UPDATED
*/



----------------------------------------------------------------------
-- Section 6.2 !!!SEE DIAGRAM ON PAGE FOLLOWING PAGE!!! User wants view the profiles of all men with their profile information (including their profile picture, Name, DOB, Location, and answers to any optional profile questions they chose to answer). Also, ensure that I can view anyone that I have not been blocked by and anyone who I have not blocked.
	
SELECT `ID_User` 
	FROM `User` 
	JOIN `Block` 
	ON `Block`.`ID_User`=`User`.`ID_User`
	WHERE `Gender_Code`=`1` AND WHERE `ID_User_Blockee` !=`3` AND `ID_User_Blocker` !=`3`;
SELECT `User` (`Uuid_User`, `First_Name`, `Last_Name`, `Date_Of_Birth`, `User_Email`, `Latitude`, `Longitude`) 
	WHERE `Age_Band`=`1`;
SELECT `Photograph` (`Uuid_Photograph`, `ID_User`, `Photograph_Name`, `Photograph_Caption`, `Primary`) 
	WHERE `Primary`=<VALUE>;
	
	
	