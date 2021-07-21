/*
Description: 
	This file is used with the video from chapter 4, class 21
	Commands are ran per individual selected code section, so not intended to run all at once.
*/


USE [Chapter 4 - Insurance]



/*
Functions used in this session.
	Function	| Meaning
	----------------------
	AVG 		| Calculates the AVERAGE of numeric values
	SUM			| Sums numeric values
	COUNT		| Counts the occurence
	DISTINCT	| Assures we count unique values only
*/



/* 
Question A: What is the Mean Insurance Covers and Premium Paid Across the Age Groups in 2014

If we breakdown the question;
	- Calculate the MEAN (the average)
	- Filter on insurance covers and premium paid
	- Group by age groups
	- Filter on the year 2014

- What is unclear is, what do they mean, the mean PER CUSTOMER, or the mean PER TRANSACTION. I will comment the code accordingly

So, what do we need?
	- Age
	- Insurace Cover yes/no
	- Premium paid amount
	- underwriting year / date (in real life the specific date might be a more detailed variable)
*/


-- Let's look at the data
SELECT
	*
FROM
	[dbo].[Member] AS [tbl_member]
-- From here we can gather:
-- Age & Memberkey



-- Let's see the other datasets available to us, to see how we can link them to get the required data
SELECT
	*
FROM
	[dbo].[MemberCover] AS [tbl_membercover]
-- From here we can gather:
-- MemberKey & Insurance year covered yes/no & Covered / Premium amounts & Underwriting Year



-- Let's start with building from the datatable with the most available parameters for us
SELECT
	SUM([total_death_cover]) -- Calculate the SUM of all transactions
FROM
	[dbo].[MemberCover] AS [tbl_membercover]
WHERE
	[underwriting_year] = 2014 -- Filter on 2014
-- It works, but it is far too generic for now and does not calculate the average yet



-- We could technically calc the average like so:
SELECT
	SUM([total_death_cover]) / (SELECT COUNT(*) FROM [dbo].[Member])
FROM
	[dbo].[MemberCover] AS [tbl_membercover]
WHERE
	[underwriting_year] = 2014
/*
	Result: $ 115,832.73
	This is how we learned to calculate an average in elementary school, however
	We are not sure whether there is coverage available to all members, as we gather our data from the MEMBER table
*/


-- To illustrate the issue with the above code:

SELECT COUNT(*) FROM [dbo].[Member] 
-- Result: 10663
SELECT COUNT(*) FROM [dbo].[MemberCover] 
-- Result: 53250
SELECT COUNT(*) FROM [dbo].[MemberCover] WHERE [underwriting_year] = 2014 
-- Result: 10650
SELECT COUNT(DISTINCT([MemberKey])) FROM [dbo].[MemberCover] WHERE [underwriting_year] = 2014
-- Result: 10650


/*
	So we can see that there are 13 less insured people covered in 2014, this will alter the average sum 
	(although we are not sure to which extent but we should learn to write good code!)
*/


-- We will select unique values for our table containins members which are insurance covered
SELECT
	COUNT(DISTINCT([MemberKey])) -- Assure we have unique values by using DISTINCT
FROM
	[dbo].[MemberCover] AS [tbl_membercover]
WHERE
	[underwriting_year] = 2014
-- Result: 10650


-- We could technically calc the average like so:
SELECT
	SUM([total_death_cover]) / 
	(SELECT COUNT(([MemberKey])) FROM [dbo].[MemberCover] WHERE [dbo].[MemberCover].[underwriting_year] = 2014) -- Assure we have unique values by using DISTINCT
FROM
	[dbo].[MemberCover] AS [tbl_membercover]
WHERE
	[tbl_membercover].[underwriting_year] = 2014
/*
	Result: $ 115,974.12
	This seems reasonable, the result is slight higher than before, but our divider (amount of members) also went down by 13.
	On a group of more than 10.000 members, having a deviation of 13, it makes sense that the result is only slightly higher.
*/


-- Now, we can also use the AVG function
SELECT
	AVG([total_death_cover]) 
FROM
	[dbo].[MemberCover] AS [tbl_membercover]
WHERE
	[tbl_membercover].[underwriting_year] = 2014
/* 
	Result: $ 165,123.58
	This result is much different and here I find the Udemy class a bit confusing. 
	When I simply look at the numbers it does not make sense to have such a difference, so I will investigate a bit deeper for myself to get true understanding

	When we consider our initial manual method, we have considered members who were covered, but ignored to check which ones never received a payout. 
	When no payout was paid, the amount is stored in the DB as a NULL value. So if we remove this group by adding a HAVING condition, we should get the same result
*/


-- When counting the members with the added condition
SELECT COUNT(DISTINCT([MemberKey]))
FROM [dbo].[MemberCover] AS [tbl_membercover]
WHERE [underwriting_year] = 2014 AND [total_death_cover] > 0 -- Added condition
/*
	Result 7.480
	This is a big discrepancy compared to the 10.650 members we counted previously. 
	More importantly, the deviaition is roughly 30%, which makes the deviation from 110k to 165k in our results also more realistic to assume
*/


-- When we now recalculate, the result should come out the same as when using AVG
SELECT
	SUM([total_death_cover]) / COUNT(DISTINCT([MemberKey]))
FROM
	[dbo].[MemberCover] AS [tbl_membercover]
WHERE
	[tbl_membercover].[underwriting_year] = 2014 AND
	[tbl_membercover].[total_death_cover] > 0
/*
	Result: $ 165,123.58
	And it does, clearly the error was something in the divider

	This result is the same when using AVG, but why?
	I discovered NULL values in the total_death_cover column, and removed these NULLS by adding a condition which checks on a numeric value, and whether that is higher than 0
*/


-- An alternative is the following code:
SELECT
	SUM([total_death_cover]) / COUNT(DISTINCT([MemberKey]))
FROM
	[dbo].[MemberCover] AS [tbl_membercover]
WHERE
	[tbl_membercover].[underwriting_year] = 2014 AND
	[tbl_membercover].[total_death_cover] IS NOT NULL -- alternative condition
-- Result: $ 165,123.58


/*
	Now there is only one more catch. Why are there NULL values? 
	These are discussions to have with the database creator, it might become an important question for our future Business Intelligence report.
	An alternative is have an in-depth look at the database structure, but that goes too far for this course.

	To conclude;
	- The AVG is SUM / N
	- AVG function takes into account NULL values, where a manual writing of the code would require more conditions
	- Conclusion is that AVG is a very useful function, but not necesarily always the answer. The question is what those NULLS represent in your database structure
*/



/*
	The original question was; What is the Mean Insurance Covers and Premium Paid Across the Age Groups in 2014?
	We will continue to use the AVG function and answer the question
*/

-- Introducing ages
SELECT
	 [tbl_member].[age] -- Ages added
	,AVG([total_death_cover]) 
FROM
	[dbo].[MemberCover] AS [tbl_membercover] INNER JOIN
	[dbo].[Member] AS [tbl_member] -- Added another source for ages
	ON [tbl_membercover].[MemberKey] = [tbl_member].[MemberKey]
WHERE
	[tbl_membercover].[underwriting_year] = 2014
GROUP BY
	[tbl_member].[age]
ORDER BY
	[tbl_member].[age]
-- It works, but the question asked multiple types of coverages, so lets build that in


-- Adding all type of coverage groups
SELECT
	 [tbl_member].[age]
	,AVG([total_death_cover])			AS [TotalDeathCover]
	,AVG([total_death_cover_premium])	AS [TotalDeathCoverPremium]
	,AVG([total_ip_cover])				AS [TotalIPCover]
	,AVG([total_ip_cover_premium])		AS [TotalIPCoverPremium]
	,AVG([total_tpd_cover])				AS [TotalTPDCover]
	,AVG([total_tpd_cover_premium])		AS [TotalTPDCoverPremium]
FROM
	[dbo].[MemberCover] AS [tbl_membercover] INNER JOIN
	[dbo].[Member] AS [tbl_member]
	ON [tbl_membercover].[MemberKey] = [tbl_member].[MemberKey]
WHERE
	[tbl_membercover].[underwriting_year] = 2014
GROUP BY
	[tbl_member].[age]
ORDER BY
	[tbl_member].[age]
-- And we are done!
