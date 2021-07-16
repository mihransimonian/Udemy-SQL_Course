/*
Description: 
	This file is used with the video from chapter 3, class 15
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
-- Now we have a few details about customers. But, we would like to know in which city I have cutomers and in which city not.


-- RIGHT Join statement to get the customers, living in each individual city
-- This should show cities, including those cities where no customers live.
-- When using a LEFT OUTER JOIN, it would show all customers, but not all cities, so we apply RIGHT OUTER JOIN
SELECT
	 [LastName]
	,[Gender]
	,[City]
FROM
	[dbo].[Customer] AS tbl_customer RIGHT OUTER JOIN
	[dbo].[Geography] AS tbl_geography
	ON tbl_customer.[GeographyKey] = tbl_geography.[GeographyKey]



-- Demonstrating the code returns the same data when we remove the OUTER from RIGHT OUTER JOIN.
SELECT
	 [LastName]
	,[Gender]
	,[City]
FROM
	[dbo].[Customer] AS tbl_customer RIGHT JOIN -- removed OUTER
	[dbo].[Geography] AS tbl_geography
	ON tbl_customer.[GeographyKey] = tbl_geography.[GeographyKey]