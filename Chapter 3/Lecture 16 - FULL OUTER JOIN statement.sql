/*
Description: 
	This file is used with the video from chapter 3, class 16
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
	,[TotalChildren]
FROM
	[dbo].[Customer] AS tbl_customer
-- Now we have a few details about customers. But, we would like to know more details about the customers.


/* 
The FULL OUTER JOIN can yield us a complete dataset from multiple tables
NULLS are returned in cases where not each details is available, from BOTH/ALL tables. 
So it combines the results of the LEFT OUTER JOIN and RIGHT OUTER JOIN
*/


-- Let's see how to apply the FULL OUTER JOIN
SELECT
	 [LastName]
	,[Gender]
	,[City]
	,[CountryRegionName]
FROM
	[dbo].[Customer] AS tbl_customer FULL OUTER JOIN
	[dbo].[Geography] AS tbl_geography
	ON tbl_customer.[GeographyKey] = tbl_geography.[GeographyKey]



-- Let's clean it up a bit
SELECT
	 [LastName]
	,[Gender]
	,[City]
	,[CountryRegionName]
FROM
	[dbo].[Customer] AS tbl_customer FULL OUTER JOIN
	[dbo].[Geography] AS tbl_geography
	ON tbl_customer.[GeographyKey] = tbl_geography.[GeographyKey]
ORDER BY -- Sorting
	[City]


/* 
The resulting table contains NULLs
NULLs are rows in which there are no records found to JOIN from in BOTH tables at the same time. 
This can help getting a better overview of all data, our customer database, do profiling, find missing links and so on.

Not mentioned here, but another useful purpose is to see no Product_ID in our product database, but the Product_ID does occur in our Inventory database.
*/


-- Demonstrating the code returns the same data when we remove the OUTER from FULL OUTER JOIN.
SELECT
	 [LastName]
	,[Gender]
	,[City]
	,[CountryRegionName]
FROM
	[dbo].[Customer] AS tbl_customer FULL JOIN -- removed OUTER
	[dbo].[Geography] AS tbl_geography
	ON tbl_customer.[GeographyKey] = tbl_geography.[GeographyKey]
ORDER BY -- Sorting
	[City]






-- My own addition:
-- Let's build the example of checking the inventory
-- Not mentioned here, but another useful purpose is to see no Product_ID in our product database, but the Product_ID does occur in our Inventory database.

	-- Check datatable
	SELECT
		*
	FROM
		[dbo].[Product] AS tbl_product


	-- As this is just an example, lets do a quick check on productname
	SELECT
		[ProductName]
	FROM
		[dbo].[Product] AS tbl_product


	-- We want to link it to our inventory, but we are not sure what is the current inventory amount parameter called
	SELECT
		*
	FROM
		[dbo].[ProductInventory] AS tbl_inventory


	-- We have found the parameter; UnitsBalance
	SELECT
		[UnitsBalance]
	FROM
		[dbo].[ProductInventory] AS tbl_inventory


	-- Let's combine them to see what we have
	SELECT
		[ProductName]
		,[UnitsBalance]
		,tbl_inventory.[ProductKey]
	FROM
		[dbo].[Product] AS tbl_product FULL OUTER JOIN
		[dbo].[ProductInventory] AS tbl_inventory
		ON tbl_product.[ProductKey] = tbl_inventory.[ProductKey]
	ORDER BY ProductKey -- Sorting will help us to identify NULLs quicker

-- End of my own addition



-- -- Quiz -- --
-- Question 1: Create a FULL JOIN on tables Supplier and ProductSupplier selecting Supplier and the average lead time for the product supplier
	
	-- Step 1: General code to understand our tables
	SELECT
		*
	FROM
		[dbo].[Supplier] AS tbl_Supplier 
	-- SupplierKey is the Primary key to use here (also visible in the Explorer window)


	--
	SELECT
		*
	FROM
		[dbo].[ProductSupplier] AS tbl_ProductSupplier 
	-- SupplierKey is the Foreign key to use here (also visible in the Explorer window)


	-- Let's combine the two databases and use a FULL OUTER JOIN
	SELECT
		*
	FROM
		[dbo].[Supplier] AS tbl_Supplier FULL OUTER JOIN
		[dbo].[ProductSupplier] AS tbl_ProductSupplier
		ON tbl_Supplier.[SupplierKey] = tbl_ProductSupplier.[SupplierKey]
	
	
	-- Now we have gathered ALL the data, we zoom in. Normally selecting * can use a lot of resources!
	SELECT
		 [Name]
		,[AverageLeadTime]
	FROM
		[dbo].[Supplier] AS tbl_Supplier FULL OUTER JOIN
		[dbo].[ProductSupplier] AS tbl_ProductSupplier
		ON tbl_Supplier.[SupplierKey] = tbl_ProductSupplier.[SupplierKey]
	ORDER BY
		[Name]
	
	-- Question related to data in database, 'What is the lead time value for 'Crowley Sport' ?'
	-- Answer: NULL (data not available); correct answer
	

/* My Bonus question:	
-- Now we see a list of suppliers, but double names. 
-- This is likely because the supplier delivers multiple products.
-- It really depends on the situation what to do next. Usually you should leave it as is, because you want to know the individual products, for each supplier.
-- As this is a course, let's dive deepr in our coding though
*/
	SELECT
		 [Name]
		,AVG([AverageLeadTime]) -- This averages ALL products from an individual supplier (specific question, normally bad practice in real life!)
	FROM
		[dbo].[Supplier] AS tbl_Supplier FULL OUTER JOIN
		[dbo].[ProductSupplier] AS tbl_ProductSupplier
		ON tbl_Supplier.[SupplierKey] = tbl_ProductSupplier.[SupplierKey]
	GROUP BY
		[Name] -- In this case it is automatically sorted as well in ascending order.

