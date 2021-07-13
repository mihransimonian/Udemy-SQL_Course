/*
Description: 
	This file is used with the video from chapter 2, class 8
	Commands are ran per individual selected code section, so not intended to run all at once.
*/

-- Select all females from the customer table
SELECT 
	*
FROM 
	[dbo].[Customer]
WHERE 
	[Gender] = 'F'



-- Let's add a new expression, but this time we will use a 'like' instead of '='
-- Note the use of the %, I will go deeper into it later
SELECT 
	*
FROM 
	[dbo].[Customer]
WHERE 
	[Occupation] LIKE '%Prof%'


/* -- Start of my own addition -- */
	-- We can also alter the use of % to change our filter --
	-- Contains =>  %...%
	SELECT 
		*
	FROM 
		[dbo].[Customer]
	WHERE
		[FirstName] LIKE '%an%'


	-- Starts with =>  ...%
	SELECT 
		*
	FROM 
		[dbo].[Customer]
	WHERE 
		[FirstName] LIKE 'an%'


	-- Ends with =>  %...
	SELECT 
		*
	FROM 
		[dbo].[Customer]
	WHERE
		[FirstName] LIKE '%an'
/* -- End of my own addition -- */




-- Search based on a simple equality condition (equal to)
SELECT 
	*
FROM 
	[dbo].[Customer]
WHERE 
	[Gender] = 'F'

-- Search based on the LIKE condition (contains)
SELECT 
	*
FROM 
	[dbo].[Customer]
WHERE 
	[Occupation] LIKE '%Prof%'


-- Search based on a comparison operator (greater or equal)
SELECT 
	*
FROM 
	[dbo].[Customer]
WHERE 
	TotalChildren >= 4



	
-- Search meeting ANY of the 3 conditions
SELECT 
	*
FROM 
	[dbo].[Customer]
WHERE 
	[Gender] = 'F' OR
	TotalChildren >= 4 OR
	[Occupation] LIKE '%Prof%'


	
-- Search meeting ANY of the 3 conditions
SELECT 
	*
FROM 
	[dbo].[Customer]
WHERE 
	TotalChildren >= 4 OR
	YearlyIncome <= 60000 OR
	HouseOwnerFlag = '1' -- Note this column contains numbers, but they are of the character datatype


		
-- Search meeting ALL of the 3 conditions
SELECT 
	*
FROM 
	[dbo].[Customer]
WHERE 
	TotalChildren >= 4 AND
	YearlyIncome <= 60000 AND
	HouseOwnerFlag = '1' -- Note this column contains numbers, but they are of the character datatype


-- Search using a range check
SELECT 
	*
FROM 
	[dbo].[Customer]
WHERE 
	YearlyIncome BETWEEN 40000 AND 80000



-- -- Quiz -- --
-- Question 1: 'How many customers have an income less than or equal $60,000 ?'
SELECT 
	*
FROM 
	[dbo].[Customer]
WHERE
	YearlyIncome <= 60000
-- Answer:  11753


-- Question 2: How many customers own their home, earn > 100,000 and are married ?
SELECT 
	*
FROM 
	[dbo].[Customer]
WHERE
	HouseOwnerFlag = '1' AND -- Note this column contains numbers, but they are of the character datatype
	YearlyIncome > 100000 AND
	MaritalStatus = 'M'
-- Answer:  858