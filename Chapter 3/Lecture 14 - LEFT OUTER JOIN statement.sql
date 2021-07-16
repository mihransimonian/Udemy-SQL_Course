/*
Description: 
	This file is used with the video from chapter 3, class 14
	Commands are ran per individual selected code section, so not intended to run all at once.
*/

-- General Command
SELECT
	*
FROM
	[dbo].[Customer]



-- Let's focus on a few parameters to get an idea of our customer
SELECT
	 [LastName]
	,[Gender]
FROM
	[dbo].[Customer] AS tbl_customer
-- Now we have a few of the details of our Client. We would like to know where this person lives, using a join statement.


-- LEFT OUTER JOIN statement to get customer residence details
SELECT
	 [LastName]
	,[Gender]
	,tbl_geography.[City] -- This is the actual information we seek, note the table I mentioned before the column!
FROM
	[dbo].[Customer] AS tbl_customer LEFT OUTER JOIN
	[dbo].[Geography] AS tbl_geography -- The table name is actually defined here, but used already under SELECT
	ON tbl_customer.[GeographyKey] = tbl_geography.[GeographyKey] -- we have to use ON when we JOIN tables, otherwise SQL does not know where to JOIN on


	
-- Demonstrating the code returns the same data when we remove the OUTER from LEFT OUTER JOIN.
SELECT
	 [LastName]
	,[Gender]
	,tbl_geography.[City]
FROM
	[dbo].[Customer] AS tbl_customer LEFT JOIN -- OUTER removed, still works
	[dbo].[Geography] AS tbl_geography
	ON tbl_customer.[GeographyKey] = tbl_geography.[GeographyKey]