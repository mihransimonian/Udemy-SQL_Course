/*
Description: 
	This file is used with the video from chapter 4, class 20
	Commands are ran per individual selected code section, so not intended to run all at once.
*/


USE [Chapter 4 - Insurance]



/*
Functions used in this session.
	Function	| Meaning
	----------------------
	SUM			| Sum of all values / all distinct values in a group
	YEAR		| Returns the year of a date (currently we use date types, not sure when it is a string type)
	IN (..)		| LIST function within SQL
	TOP(n)		| Top () x rows, influenced by ORDER BY and SELECTED columns (experiment to understand if the question is answered the way you expect!)
*/




-- Question A: Total claims $ paid for Death (DTH) and TPD claim type in year 2014

-- Let's look at the data
SELECT
	*
FROM
	[dbo].[MemberClaims] AS tbl_memberclaims


-- clean up
SELECT
	*
FROM
	[dbo].[MemberClaims] AS tbl_memberclaims
ORDER BY
	[claimpaiddate] DESC



-- Let's introduce a few functions to answer the question
SELECT
	 YEAR([claimpaiddate]) AS [Year] -- Year is used as the new variable name, so it has to be in Brackets, as YEAR is also a built-in function!
	,tbl_memberclaims.ClaimType
	,SUM([claimpaidamount]) AS TotalClaimPaid
FROM
	[dbo].[MemberClaims] AS tbl_memberclaims
GROUP BY
	 YEAR([claimpaiddate])
	,tbl_memberclaims.ClaimType
ORDER BY
	 YEAR([claimpaiddate]) DESC




-- Great, it works, however, we still don't fully answer the question, for that we need to introduce a few filters
SELECT
	 YEAR([claimpaiddate]) AS [Year]
	,tbl_memberclaims.ClaimType
	,SUM([claimpaidamount]) AS TotalClaimPaid
FROM
	[dbo].[MemberClaims] AS tbl_memberclaims
WHERE -- Add filter(s)
	tbl_memberclaims.[ClaimType] = 'TPD' OR
	tbl_memberclaims.[ClaimType] = 'DTH'
GROUP BY
	 YEAR([claimpaiddate])
	,tbl_memberclaims.ClaimType
ORDER BY
	 YEAR([claimpaiddate]) DESC



-- Introducing a LIST
-- We are not done yet, as we also need to select the year. 
-- However, we have to write a lot of lines in the Filter section for TPD and DTH.
-- We can also use a list:
SELECT
	 YEAR([claimpaiddate]) AS [Year]
	,tbl_memberclaims.ClaimType
	,SUM([claimpaidamount]) AS TotalClaimPaid
FROM
	[dbo].[MemberClaims] AS tbl_memberclaims
WHERE
	tbl_memberclaims.[ClaimType] in ('TPD', 'DTH') -- Using a LIST using in (..)
GROUP BY
	 YEAR([claimpaiddate])
	,tbl_memberclaims.ClaimType
ORDER BY
	 YEAR([claimpaiddate]) DESC


-- Let's add the year
SELECT
	 YEAR([claimpaiddate]) AS [Year]
	,tbl_memberclaims.ClaimType
	,SUM([claimpaidamount]) AS TotalClaimPaid
FROM
	[dbo].[MemberClaims] AS tbl_memberclaims
WHERE
	tbl_memberclaims.[ClaimType] in ('TPD', 'DTH') AND
	 YEAR([claimpaiddate]) = 2014 -- Year filter
GROUP BY
	 YEAR([claimpaiddate])
	,tbl_memberclaims.ClaimType
ORDER BY
	 YEAR([claimpaiddate]) DESC
-- Done!





-- Question B: Top 5 claims category for claim type TPD for 2014, grouped by member gender

-- Taking a shortcut, using the old code in filters, to match it to the question and introducing the TOP 5
SELECT 
	 TOP (5)	-- Introducing TOP 5
	 YEAR([claimpaiddate]) AS [Year]
	,[tbl_memberclaims].[ClaimType]
	,SUM([claimpaidamount]) AS [TotalClaimPaid]
FROM
	[dbo].[MemberClaims] AS [tbl_memberclaims]
WHERE
	[tbl_memberclaims].[ClaimType] in ('TPD') AND -- Claim type filter
	 YEAR([claimpaiddate]) = 2014 -- Year filter
GROUP BY
	 YEAR([claimpaiddate])
	,[tbl_memberclaims].[ClaimType]
ORDER BY
	[TotalClaimPaid] DESC -- Adjusted ordering, note we can use the var name set under SELECT
-- It works, but it will need some adjusting



-- We want to know:
	-- Claim category
	-- Member gender
	-- Top 5


-- Introducing Claim category
SELECT 
	 TOP (5)
	 YEAR([claimpaiddate]) AS [Year]
	,tbl_memberclaims.[ClaimCauseCategory] -- Introducing claim category
	,[tbl_memberclaims].[ClaimType]
	,SUM([claimpaidamount]) AS [TotalClaimPaid]
FROM
	[dbo].[MemberClaims] AS [tbl_memberclaims]
WHERE
	[tbl_memberclaims].[ClaimType] in ('TPD') AND
	YEAR([claimpaiddate]) = 2014
GROUP BY
	 YEAR([claimpaiddate])
	,[tbl_memberclaims].[ClaimCauseCategory] -- Claim category
	,[tbl_memberclaims].[ClaimType]
ORDER BY
	 [TotalClaimPaid] DESC
-- It works great, but, we should group it by gender!








-- Question: Top 5 claims category for claim type TPD for 2014, grouped by member gender

-- Introducing Gender, we will gather data from another table as we learned previously
SELECT 
	 TOP (5)
	 YEAR([claimpaiddate]) AS [Year]
	,tbl_memberclaims.[ClaimCauseCategory]
	,[tbl_memberclaims].[ClaimType]
	,[tbl_member].[gender] -- Introducing the GENDER, NOTE it is from a different table (!)
	,SUM([claimpaidamount]) AS [TotalClaimPaid]
FROM -- Here we will need to gather data from another table, and use an INNER JOIN
	[dbo].[MemberClaims] AS [tbl_memberclaims] INNER JOIN
	[dbo].[Member] AS [tbl_member]
	ON [tbl_memberclaims].[MemberKey] = [tbl_member].[MemberKey]
WHERE
	[tbl_memberclaims].[ClaimType] in ('TPD') AND
	YEAR([claimpaiddate]) = 2014
GROUP BY
	 YEAR([claimpaiddate])
	,[tbl_memberclaims].[ClaimCauseCategory]
	,[tbl_memberclaims].[ClaimType]
	,[tbl_member].[gender] -- gender
ORDER BY
	 [TotalClaimPaid] DESC


-- Side observation: some ClaimCauseCategories have disappeared, after we added the gender. This makes sense as we have introduced a new selection type (gender), but also restricted the displayed amount using TOP.




