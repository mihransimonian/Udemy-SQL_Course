/*
Description: 
	This file is used with the video from chapter 2, class 10
	Commands are ran per individual selected code section, so not intended to run all at once.
*/


-- General code
SELECT
	*
FROM
	[dbo].[Customer]


-- HouseOwnerFlag is a number (0 or 1), but currently stored in a character datatype. We cannot sumor calculate, so we have to cast it to a new datatype.

-- Convert datatypes
SELECT
	 *
	,cast([HouseOwnerFlag] as int) as 'Houseid'
FROM
	[dbo].[Customer]
