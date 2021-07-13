/*
Description: 
	This file contains general coding, just to get a feel of SQL.
	Commands are executed using selected code, to prevent unnecessary resource usage.
Class:
	This file is used with the video from chapter 2, class 7
*/

-- -- Some general coding to get a feel of SQL -- --
-- Make a constant
SELECT 123

-- Make a NAMED constant
SELECT 123 AS 'TestField'

-- Some Calculation with a NAMED constant
SELECT 123 + 123 / 2 AS 'TestField'

-- Some Calculation with a NAMED constant, note the order of mathematical precedence!
SELECT ((123 + 123) / 2) AS 'TestField'

-- -- Now we go a little bit deeper -- --

-- Quick overview using Microsoft SQL Server Management Studio, right click 'top 1000 rows'
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [CustomerKey]
      ,[GeographyKey]
      ,[CustomerAlternateKey]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[NameStyle]
      ,[BirthDate]
      ,[MaritalStatus]
      ,[Suffix]
      ,[Gender]
      ,[EmailAddress]
      ,[YearlyIncome]
      ,[TotalChildren]
      ,[NumberChildrenAtHome]
      ,[EducationLevel]
      ,[Occupation]
      ,[HouseOwnerFlag]
      ,[NumberCarsOwned]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[Phone]
      ,[DateFirstPurchase]
      ,[CommuteDistance]
  FROM [Chapter 2 - Sales ].[dbo].[Customer]


-- -- Import a column double, and give it a different name -- --
SELECT
	[CustomerKey], [CustomerKey] as 'CUSTOMERFIELD'
FROM
	[dbo].[Customer]


-- -- Select All -- --
SELECT
	*
FROM
	dbo.Customer


-- -- Quiz -- --
-- Question: 'How many rows are returned from wildcard in Product table'
SELECT * FROM dbo.Product
-- Answer: 606



