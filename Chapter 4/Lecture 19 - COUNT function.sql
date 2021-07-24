/*
Description: 
	This file is used with the video from chapter 4, class 19
	Commands are ran per individual selected code section, so not intended to run all at once.
*/



/*
Functions used in this session.
	Function	| Meaning
	----------------------
	Count		| Counts occurrences of a parameter given
	Distinct	| Finds unique values
	Over		| Allows aggregation without the need for a GROUP BY clause
	Partition By| OVER(partition by) will break up the results into partitions (like groups)
*/



-- Until now I defined only short paths, but we can instruct SQL to use a specific database using USE
-- Define the database to use
USE [Chapter 4 - Insurance]


-- SQL Comes with built-in functions. Let's try to answer a few questions using the COUNT function


-- Some general code
SELECT
	*
FROM
	[dbo].[Member]


-- This will count all the rows
SELECT
	COUNT(*)
FROM
	[dbo].[Member]



-- Question: How many members do we have by gender? --
	-- Let's define the parameters we want to use
	SELECT
		[gender]
	FROM
		[dbo].[Member]
	-- This works, let's grouping the items


	-- Group the items using GROUP BY
	SELECT
		[gender]
	FROM
		[dbo].[Member]
	GROUP BY
		[gender]
	-- Great, we have two genders, now we know that we don't have a NULL value (this is important for data cleaning excercises in real life!)



	-- We do want to know the actual amount, so we should use the COUNT() function
	SELECT
		COUNT([gender])
	FROM
		[dbo].[Member]
	GROUP BY
		[gender]
	-- This will result in just two numbers, we don't know which number relates to what, so we should add a second parameter....


	-- We can add the second parameter, I did it in this order for presentation purposes
	SELECT
		 [gender]
		,COUNT([gender]) AS count_gender
	FROM
		[dbo].[Member]
	GROUP BY
		[gender]



-- Question: How many distinct occupations do our members have? --
-- I have made two solutions for this question!

	-- As we understand our database already a bit better, let us immediately make a jump in code
	SELECT
		 [occupation]
		,COUNT([occupation]) AS count_occupation
	FROM
		[dbo].[Member]
	GROUP BY
		[occupation]
	ORDER BY
		[occupation] -- Looks nicer for presentation purposes
	-- The returned list counts every member for each unique occupation


	-- There is also another option to do this, which only shows the total amount of unique occupations. We use the DISTINCT function for this
	SELECT
		COUNT(DISTINCT([occupation])) AS count_unique_occupation
	FROM
		[dbo].[Member]
	-- This is just one number, which counts all the unique occupations in our member list


-- Just to demonstrate the DISTINCT function
SELECT DISTINCT([occupation]) FROM [dbo].[Member]
-- This returns a list of all unique values in the parameter/column: occupations


-- Question: Supply a list of duplicated member biz keys --
	SELECT
		 [member_biz_key]
		,COUNT([member_biz_key]) AS count_member_biz_key
	FROM
		[dbo].[Member]
	GROUP BY
		[member_biz_key]
	ORDER BY
		[count_member_biz_key] DESC -- Looks nicer for presentation purposes
	-- 	This will supply us a with a list of just random numbers and also numbers with just one count whilst we want to find only the duplicates


	-- We want to know the duplicates, so we add a filter using HAVING
	SELECT
		 [member_biz_key]
		,COUNT([member_biz_key]) AS count_member_biz_key
	FROM
		[dbo].[Member]
	GROUP BY
		[member_biz_key]
	HAVING
		COUNT([member_biz_key]) > 1 -- We need to repeat the function (!)
	ORDER BY
		[member_biz_key] -- Notice we use a different column now, as we already filtered the 1




-- Question: Count the countries of all our members
	SELECT
		 [country]
		,COUNT([country]) AS count_unique_countries
	FROM
		[dbo].[Member]
	GROUP BY
		[country]
	-- This presents a list of all member counts per each individual country

	
	SELECT	
		COUNT(DISTINCT([country])) AS count_unique_countries
	FROM
		[dbo].[Member]
	-- This presents a list of all unique countries in which our members reside




-- We are going to change to another database, to make things more interesting
USE [Chapter 3 - Sales (Keyed)]

-- Question: The sales manager wants a list of product counts in each online sales order to evaluate the greatest product count overall

	-- Let's first get our data loaded and decide parameters
	SELECT
		*
	FROM
		[dbo].[OnlineSales]
	-- We want orderQuantity, SalesOrderNumber, ProductKey


	-- Let's first get our data loaded
	SELECT
		COUNT([orderQuantity])
	FROM
		[dbo].[OnlineSales]

	-- Normally you would use a GROUP BY, as we also want to add another parameter (productkey)
	-- Instead we will use the OVER(PARTITION BY)
	SELECT
		 [SalesOrderNumber]
		,COUNT([orderQuantity]) OVER(PARTITION BY [SalesOrderNumber]) as count_products
	FROM
		[dbo].[OnlineSales]
	-- Repeat: Partition by is a way of grouping your data over a column expression


	-- It works but it is unclear how many products are sold, as data is unsorted
	SELECT
		 [SalesOrderNumber]
		,COUNT([orderQuantity]) OVER(PARTITION BY [SalesOrderNumber]) as count_products
	FROM
		[dbo].[OnlineSales]
	ORDER BY
		count_products DESC
	-- The data is now sorted, however, when we look at the row count it is still identical than the table itself! 
	
	-- We have to remove duplicate SalesOrderNumbers, we use DISTINCT for that
	SELECT
		DISTINCT COUNT([orderQuantity]) OVER(PARTITION BY [SalesOrderNumber]) as count_products
		,[SalesOrderNumber]
	FROM
		[dbo].[OnlineSales]
	ORDER BY
		count_products DESC
	-- Note one important item though, we have to change the order of our parameters in order for this to work



-- -- Quiz -- --
USE [Chapter 4 - Insurance]

-- Question 1: 'Write a query to return the count of claims where the notification date is in the year 2014 and the claimants age is between 33 and 48'

-- So we need; Age, MemberId, amount of claims and claimdate

SELECT
	*
FROM
	[dbo].[Member]
-- Here we can gather Age and MemberId

SELECT
	*
FROM
	[dbo].[MemberClaims]
-- Here we can gather MemberId, claimnotificationdate

-- As we have two tables, and two items we need to link, let's break the question up in multiple small querys


-- Let's start with finding our members with age between 33 and 48
SELECT
	 [MemberKey] -- Required for joining tables later on
	,[age]
FROM
	[dbo].[Member]
WHERE
	[age] >= 33 AND [age] <= 48
-- Great, this works. 



-- Let's find the claimdates occured in 2014 within the memberclaims table
SELECT
	 [MemberKey] -- Required for joining tables later on
	,[claimnotificationdate]
FROM
	[dbo].[MemberClaims]
WHERE
	[claimnotificationdate] >= '2014-01-01' AND [claimnotificationdate] < '2015-01-01'
-- Great, this also works. Now comes the joining of tables!


SELECT
	 tbl_member.[MemberKey]
	,[age]
	,[claimnotificationdate]
FROM
	[dbo].[Member] AS tbl_member INNER JOIN -- Note the INNER jointype is used
	[dbo].[MemberClaims] AS tbl_memberclaims
	ON tbl_member.[MemberKey] = tbl_memberclaims.[MemberKey]
-- The tables are joined and we have the same row count as the claimtable unjoined, so we did not loose any data for using the inner jointype. 


-- However, we did not filter anything yet so let's build our query more
SELECT
	 tbl_member.[MemberKey]
	,[age]
	,[claimnotificationdate]
FROM
	[dbo].[Member] AS tbl_member INNER JOIN
	[dbo].[MemberClaims] AS tbl_memberclaims
	ON tbl_member.[MemberKey] = tbl_memberclaims.[MemberKey]
WHERE
	[age] >= 33 AND 
	[age] <= 48 AND
	[claimnotificationdate] >= '2014-01-01' AND 
	[claimnotificationdate] < '2015-01-01'
