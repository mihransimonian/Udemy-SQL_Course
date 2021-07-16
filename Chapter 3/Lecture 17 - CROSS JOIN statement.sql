/*
Description: 
	This file is used with the video from chapter 3, class 17
	Commands are ran per individual selected code section, so not intended to run all at once.
*/


-- This is an odd type of JOIN and should only be used in specific conditions and is computationally very heavy, use with caution.
-- Let's go back to our previous example and see the difference.
SELECT
	 [LastName]
	,[Gender]
	,[City]
FROM
	[dbo].[Customer] as tbl_customer FULL OUTER JOIN
	[dbo].[Geography] as tbl_geography
	ON tbl_customer.[GeographyKey] = tbl_geography.[GeographyKey]
-- Duration: 0m 0s
-- Rows: 18.805 rows
-- So, this is a quick query. Now let's see the effect on the CROSS JOIN (Cartesian JOIN)


/*
	A CROSS JOIN is not your normal JOIN and takes up A LOT of computational resources
	It's result is a MATRIX Multiplication, and can be useful for very specific situations
	The CARTESIAN product is important here to be aware of
	Again, very heavy for your computer and you should use it only with caution!
	I will just upload the command to do a CROSS JOIN, just to demonstrate the effect
*/


-- The CROSS JOIN
SELECT
	 [LastName]
	,[Gender]
	,[City]
FROM
	[dbo].[Customer] as tbl_customer CROSS JOIN
	[dbo].[Geography] as tbl_geography
-- Duration: 1m 16s
-- Rows: 12.125.504 rows


/*
	The original FULL OUTER JOIN had:
	Duration: 0m 0s
	Rows: 18.805 rows
	The use of CROSS JOIN can lead to server problems, so use with caution
*/
