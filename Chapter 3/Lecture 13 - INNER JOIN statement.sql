/*
Description: 
	This file is used with the video from chapter 3, class 13
	Commands are ran per individual selected code section, so not intended to run all at once.
*/

-- General Command
SELECT
	*
FROM
	[dbo].[Product]


-- Let's select some specific fields
SELECT
	 ProductName
	,ListPrice
FROM
	[dbo].[Product]


-- INNER JOIN command
-- Let's understand our product inventory
SELECT
	 [ProductName]
	,[ListPrice]
FROM
	[dbo].[Product] INNER JOIN [dbo].[ProductInventory]
	ON [dbo].[Product].ProductKey = [dbo].[ProductInventory].ProductKey -- This is the statement which determines the columns to join on


-- INNER JOIN command
-- We can improve readability by introducing nicknames/aliases
SELECT
	 [ProductName]
	,[ListPrice]
FROM
	[dbo].[Product] AS tbl_product INNER JOIN -- note the alias 'tbl_product', far improving code readability
	[dbo].[ProductInventory] AS tbl_product_inventory 
	ON tbl_product.ProductKey = tbl_product_inventory.ProductKey


-- INNER JOIN command
-- It is also easy to simply add a new columns
SELECT
	 [ProductName]
	,[ListPrice]
	,[ProductName]
	,[DateKey]
FROM
	[dbo].[Product] AS tbl_product INNER JOIN
	[dbo].[ProductInventory] AS tbl_product_inventory 
	ON tbl_product.ProductKey = tbl_product_inventory.ProductKey



-- only JOIN command
-- It works, but it makes it harder to understand the type of join. 
-- So we prefer to write it out in full, as we might combine type of JOINS in advanced querys
SELECT
	 [ProductName]
	,[ListPrice]
	,[ProductName]
	,[DateKey]
FROM
	[dbo].[Product] AS tbl_product JOIN
	[dbo].[ProductInventory] AS tbl_product_inventory 
	ON tbl_product.ProductKey = tbl_product_inventory.ProductKey




-- -- Quiz -- --
-- Question: Create a JOIN on the tables Product and ProductSubcategory, select the ProductName,Color and ProductSubcategoryName where the subcategory = 'Jerseys'?
	
	-- General code
	SELECT
		*
	FROM
		[dbo].[Product] AS tbl_Product


	-- Select the columns, note we do not have ProductSubcategoryName in this table
	SELECT
		 [ProductName]
		,[Color]
	FROM
		[dbo].[Product] AS tbl_Product


	-- JOIN the tables
	SELECT
		 [ProductName]
		,[Color]
		,[ProductSubcategoryName] -- Note that only with the joined table this field becomes available
	FROM
		[dbo].[Product] AS tbl_Product INNER JOIN
		[dbo].[ProductSubcategory] AS tbl_ProductSubCategory
		ON tbl_Product.ProductSubcategoryKey = tbl_ProductSubCategory.ProductSubcategoryKey


	-- Add the last constraint
	SELECT
		 [ProductName]
		,[Color]
		,[ProductSubcategoryName]
	FROM
		[dbo].[Product] AS tbl_Product INNER JOIN
		[dbo].[ProductSubcategory] AS tbl_ProductSubCategory
		ON tbl_Product.ProductSubcategoryKey = tbl_ProductSubCategory.ProductSubcategoryKey
	WHERE
		[ProductSubcategoryName] = 'Jerseys'
