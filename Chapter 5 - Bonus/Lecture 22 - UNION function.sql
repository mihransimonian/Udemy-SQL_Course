/*
	Description: 
	This file is used with the video from chapter 5 (bonus), class 22
	Commands are ran per individual selected code section, so not intended to run all at once.
*/


-- We use an old DB for this bonus chapter
USE [Chapter 3 - Sales (Keyed)] 


/*
Functions used in this session.
	Function	| Meaning
	----------------------
	UNION		| Combine the result of 2 or more querys
*/


/*
	UNION - Combines result from 2 or more querys. Do not confuse with JOINS!
	Joins combine two datatables, and then you run a QUERY over them
	You can actually also use a UNION to combine tables etc. but for now, we will stick to just using it to combine the result of two individual querys.
	
	Some important points on UNION
	- By default, duplicates are removed (!)
	- Use UNION ALL to retain the duplicate rows from EACH result query set
	- Target columns must bethe same across the queries (also their datatypes!)
	- The first query determines the column names for the resulting dataset
*/



-- We want to figure out the average prices from our suppliers, with a certain creditrating

-- Let's start
SELECT	* 
FROM	[dbo].[Supplier]


-- Let's build our query for creditrating 1
SELECT
	 [tbl_supplier].[Name]
	,[tbl_supplier].[CreditRating]
FROM
	[dbo].[Supplier] AS [tbl_supplier]
WHERE
	[tbl_supplier].[CreditRating] = 1 -- Our filter
GROUP BY
	 [tbl_supplier].[Name]
	,[tbl_supplier].[CreditRating]


-- Let's gather their prices
SELECT
	 [SupplierKey]
	,AVG([StandardPrice]) AS [AvgStdPrice]
FROM		
	[dbo].[ProductSupplier]
GROUP BY	
	[SupplierKey]


-- Let's combine to make our query
SELECT
	 [tbl_supplier].[Name]
	,AVG([StandardPrice]) AS [AvgStdPrice]
	,[tbl_supplier].[CreditRating]
FROM
	[dbo].[Supplier] AS [tbl_supplier] INNER JOIN
	[dbo].[ProductSupplier] AS [tbl_productsupplier]
	ON [tbl_supplier].[SupplierKey] = [tbl_productsupplier].[SupplierKey]
WHERE
	[tbl_supplier].[CreditRating] = 1
GROUP BY
	 [tbl_supplier].[Name]
	,[tbl_supplier].[CreditRating]
-- Adding another query will give us two resulting arrays. With UNION we can COMBINE THE RESULTING ARRAY


UNION -- UNION goes BETWEEN the queryes
-- What to do if we want to assure we keep  the duplicates? -> UNION ALL

-- Now lets do this for creditrating of 4
SELECT
	 [tbl_supplier].[Name]
	,AVG([StandardPrice]) AS [AvgStdPrice]
	,[tbl_supplier].[CreditRating]
FROM
	[dbo].[Supplier] AS [tbl_supplier] INNER JOIN
	[dbo].[ProductSupplier] AS [tbl_productsupplier]
	ON [tbl_supplier].[SupplierKey] = [tbl_productsupplier].[SupplierKey]
WHERE
	[tbl_supplier].[CreditRating] = 4
GROUP BY
	 [tbl_supplier].[Name]
	,[tbl_supplier].[CreditRating]

/*
	So to recap; 
	make sure you have datatypes the same, 
	that column names are determined in the first query 
	understand that UNION is not a JOIN.
	assure no duplicate is thrown away, use UNION ALL
*/
