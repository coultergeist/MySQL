/*
Create table to determine the salaries of Washington State public employees.
Created May 1, 2016
Database Administrator: Danielle Coulter, Employee ID: 89456. Seattle, WA.
The Best Co., 555 Main St., Anytown, USA 12345
*/

-- Titled table `Public_Salary`--
CREATE TABLE `Public_Salary`
(
	Agency INTEGER(11) COMMENT 'All Agencies created/named by WA state',
	AgencyTitle VARCHAR(255) COMMENT 'Sub-catagory of Agencies',
	EmployeeName VARCHAR(100) COMMENT 'Last, First, MI. Note: name are not in one singular format. It is unknown if employees have middle initials or no middle name at all',
	JobTitle VARCHAR(255) COMMENT 'Title of each employee. Only one title for each employee',
	Salary2010 VARCHAR(255) COMMENT 'Salary for year 2010',
	Salary2011 INTEGER(11) COMMENT 'Salary for year 2011',
	Salary2012 INTEGER(11) COMMENT 'Salary for year 2012',
	Salary2013 INTEGER(11) COMMENT 'Salary for year 2013' 
)ENGINE INNODB COMMENT 'This data was created by the State of Washington, therefore all tables were left as they created them. Import of CSV file only.';
	
	
-- Retrieved data from https://data.wa.gov/Labor/Annual-Salary-2010-thru-2013-/y3ds/rkew --
-- Since working on a network, you must switch the directory so that you can directly load the data into mysql--
	LOAD DATA LOCAL INFILE 'Salary.sql'
		INTO TABLE `Public_Salary`
		FIELDS TERMINATED BY ','
		OPTIONALLY ENCLOSED BY '"'
		IGNORE 1 ROWS;


-- Did not assign a primary key when table was created, did so now--
	ALTER TABLE `Public_Salary`
		ADD COLUMN pk_ID INT auto_increment PRIMARY KEY FIRST;

	-- mysql> SELECT * FROM `Public_Salary` limit 10;--
-- +-------+--------+-------------+--------------------+-------------------------------+------------+------------+------------+------------+--
-- | pk_ID | Agency | AgencyTitle | EmployeeName       | JobTitle                      | Salary2010 | Salary2011 | Salary2012 | Salary2013 |--
-- +-------+--------+-------------+--------------------+-------------------------------+------------+------------+------------+------------+--
-- |     1 |    165 | Accountancy | ASMATH, MOSAR      | FORMS & RECORDS ANALYST 2     | 0          |          0 |          0 |      32272 |--
-- |     2 |    165 | Accountancy | AUBREY, DONALD F   | BOARD MEMBER                  | 0          |        950 |       1450 |          0 |--
-- |     3 |    165 | Accountancy | BREN, DIANE MARIE  | WMS BAND 3                    | 15004      |          0 |          0 |          0 |--
-- |     4 |    165 | Accountancy | CLARK, ROBIN       | BOARD MEMBER                  | 550        |          0 |          0 |          0 |--
-- |     5 |    165 | Accountancy | DONOVAN, KIRSTEN M | ADMINISTRATIVE TRAINEE 3      | 0          |          0 |          0 |      15182 |--
-- |     6 |    165 | Accountancy | EDDY, MICHELLE S   | CUST SVS SPEC 4               | 42142      |          0 |          0 |          0 |--
-- |     7 |    165 | Accountancy | EDDY, MICHELLE S   | CUSTOMER SERVICE SPECIALIST 4 | 0          |      39369 |       5421 |       4323 |--
-- |     8 |    165 | Accountancy | EDDY, MICHELLE S   | FORMS & RECORDS ANALYST 3     | 0          |       3800 |      39682 |          0 |--
-- |     9 |    165 | Accountancy | HUTCHINS, ROBERT G | BOARD MEMBER                  | 550        |        550 |        350 |          0 |--
-- |    10 |    165 | Accountancy | JASSNY, LAUREN     | BOARD MEMBER                  | 350        |        350 |        150 |          0 |--
-- +-------+--------+-------------+--------------------+-------------------------------+------------+------------+------------+------------+--
-- 10 rows in set (0.00 sec)--
	
	
	
-- Created indexes for the 3 most common queries--
	
-- Index: how many agencies are represented in the database--	
	CREATE INDEX index_Agency
		ON `Public_Salary` (Agency);	
-- Query OK, 0 rows affected (5.06 sec)--
-- Records: 0  Duplicates: 0  Warnings: 0--

-- Index: how many different job titles are in the data--
	CREATE INDEX index_JobTitles
		ON `Public_Salary` (JobTitle);
-- Query OK, 0 rows affected (5.75 sec)--
-- Records: 0  Duplicates: 0  Warnings: 0--

-- Index: 2012 highest salary of all public employees--
	CREATE INDEX index_Salary2012
		ON `Public_Salary` (Salary2012);
-- Query OK, 0 rows affected (3.19 sec)--
-- Records: 0  Duplicates: 0  Warnings: 0--



-- Results of the indexes for the 3 most common queries--
-- !!!Watch: There are no spaces after the function description and before the (!!!---


-- Results: Distinct number of agencies present 339,763--
	SELECT COUNT(`AgencyTitle`) 
		from `Public_Salary`;
-- +----------------------+--
-- | count(`AgencyTitle`) |--
-- +----------------------+--
-- |               339763 |--
-- +----------------------+--
-- 1 row in set (1.05 sec)--

-- Results: Total number of job titles 17,133 --
	SELECT COUNT(DISTINCT(`JobTitle`))
		FROM `Public_Salary`;
-- +-----------------------------+--
-- | COUNT(DISTINCT(`JobTitle`)) |--
-- +-----------------------------+--
-- |                       17133 |--
-- +-----------------------------+--
-- 1 row in set (0.24 sec)--

-- Multi-part result section: Highest salary, of 2012, and their name--
-- Result: Max 2012 salary $2,736,431--
	SELECT MAX(Salary2012) 
		FROM `Public_Salary`;
-- +-----------------+--
-- | max(Salary2012) |--
-- +-----------------+--
-- |         2736431 |--
-- +-----------------+--
-- 1 row in set (0.00 sec)--

-- Result:  Stephen Sarkisian, Name of the public employee who earned the highest salary of 2012--
	SELECT * FROM `Public_Salary`
		WHERE `Salary2012`=2736431;
-- +--------+--------+---------------------------+----------------------+----------------+------------+------------+------------+------------+--
-- | pk_ID  | Agency | AgencyTitle              | EmployeeName         | JobTitle       | Salary2010 | Salary2011 | Salary2012 | Salary2013 |--
-- +--------+--------+--------------------------+----------------------+----------------+------------+------------+------------+------------+--
-- | 272124 |    360 | University of Washington | SARKISIAN, STEPHEN A | COACH-FOOTBALL | 1982918    |    2529168 |    2736431 |    2633642 |--
-- +--------+--------+--------------------------+----------------------+----------------+------------+------------+------------+------------+--
-- 1 row in set (0.02 sec)