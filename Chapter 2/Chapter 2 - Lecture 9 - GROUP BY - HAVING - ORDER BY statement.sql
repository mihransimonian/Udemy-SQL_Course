/*
Description: 
	This file is used with the video from chapter 2, class 9
	Commands are ran per individual selected code section, so not intended to run all at once.
*/

-- Example: marketing department is interested in: 
	-- Income vs Education level, separated by Gender

-- General code
SELECT
	*
FROM
	[dbo].[Customer]
-- This results in too much data, but gives us some hints to what to do next. Too much data gives no insight, so let's break it further down.


-- TIP: Do not tacle complete question in one go, break problem down in parts before you continue --


-- Step 1: decide fields of interest and isolate them
SELECT
	[YearlyIncome] -- Income
	,[EducationLevel] -- Education
	,[Gender] -- Gender
FROM
	[dbo].[Customer]


-- Goal is to get average income, so how do we calculate this?
-- Step 2: Calculate fields of interest
SELECT
	AVG([YearlyIncome]) AS [YearlyIncome] -- Income, but also set the column name
	,[EducationLevel] -- Education 
	,[Gender] -- Gender
FROM
	[dbo].[Customer]
GROUP BY -- We have to use this when we apply a calculation
	[EducationLevel]
	,[Gender]


-- Let's focus on the presentation, sorting becomes important
-- Step 3: Sorting by ORDER BY
SELECT
	AVG([YearlyIncome]) AS [YearlyIncome] -- Income, but also set the column name
	,[EducationLevel] -- Education 
	,[Gender] -- Gender
FROM
	[dbo].[Customer]
GROUP BY -- We have to use this when we apply a calculation
	[EducationLevel]
	,[Gender]
ORDER BY -- Sorting
	[YearlyIncome]


-- Just add a touch of detail
-- Step 4: Make it a descending sorting
SELECT
	AVG([YearlyIncome]) AS [YearlyIncome] -- Income, but also set the column name
	,[EducationLevel] -- Education 
	,[Gender] -- Gender
FROM
	[dbo].[Customer]
GROUP BY -- We have to use this when we apply a calculation
	[EducationLevel]
	,[Gender]
ORDER BY -- Sorting
	[YearlyIncome] DESC



-- Calculate the individual group type average using GROUP BY ROLLUP
SELECT
	AVG([YearlyIncome]) AS [YearlyIncome]
	,[EducationLevel]
	,[Gender]
FROM
	[dbo].[Customer]
GROUP BY ROLLUP ([EducationLevel] ,[Gender])




/* -- Start of my own addition -- */
	-- Lets use sorting just to see how it works
	SELECT
		AVG([YearlyIncome]) AS [YearlyIncome]
		,[EducationLevel]
		,[Gender]
	FROM
		[dbo].[Customer]
	GROUP BY ROLLUP ([EducationLevel] ,[Gender])
	ORDER BY -- Sorting
		[YearlyIncome] DESC
/* -- End of my own addition -- */



-- Introducing HAVING, used when filtering within your subgroups
SELECT
	AVG([YearlyIncome]) AS [YearlyIncome] -- Income, but also set the column name
	,[EducationLevel] -- Education 
	,[Gender] -- Gender
FROM
	[dbo].[Customer]
GROUP BY -- We have to use this when we apply a calculation
	[EducationLevel]
	,[Gender]
HAVING
	[EducationLevel] = 'Graduate Degree'
ORDER BY -- Sorting
	[YearlyIncome] DESC




-- -- Quiz -- --
-- Question 1: Write a query to answer what the average number of children still living at home versus Married and Single customers
	-- General code
	SELECT
		*
	FROM
		[dbo].[Customer]

	-- Step 1: Select variables
	SELECT 
		 [NumberChildrenAtHome]
		,[MaritalStatus]
	FROM
		[dbo].[Customer]

	-- Step 2: Calculate and think about variable presentation (as....)
	SELECT 
		 AVG([NumberChildrenAtHome]) as [NumberChildrenAtHome]
		,[MaritalStatus]
	FROM
		[dbo].[Customer]
	GROUP BY [MaritalStatus]
	-- Done


-- Question 2: What is the average yearly income for customers that are female Graduate Degree holders ?
	-- General code
	SELECT
		*
	FROM
		[dbo].[Customer]

	-- Step 1: Select variables
	SELECT
		 [YearlyIncome]
		,[Gender]
		,[EducationLevel]
	FROM
		[dbo].[Customer]

	-- Step 2: Calculate and think about variable presentation (as....)
	SELECT
		 AVG([YearlyIncome]) AS [YearlyIncome]
		,[Gender]
		,[EducationLevel]
	FROM
		[dbo].[Customer]
	GROUP BY
		 [Gender]
		,[EducationLevel]

	-- Step 3: Zoom in further and apply filtration to the new sub data to come up with a direct answer
	SELECT
		 AVG([YearlyIncome]) AS [YearlyIncome]
		,[Gender]
		,[EducationLevel]
	FROM
		[dbo].[Customer]
	GROUP BY
		 [Gender]
		,[EducationLevel]
	HAVING -- Question: female AND Graduate Degree
		[Gender] = 'F' AND
		[EducationLevel] = 'Graduate Degree'
	-- Done -- Answer: 65493