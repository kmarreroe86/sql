/* Syntax

With [Recursive] CTE_name as
(
	select query (Non recursive query or base query)
		union [all]
	select query (recursive query using CTE_name [with a termination condition])
)
select from CTE_name

*/


-- Queries
-- Q1: Display numbers from 1 to 10 without using any in built functions
with recursive numbers as
(
	select 1 as n
	union
	select n + 1
	from numbers where n < 10
)
select * from numbers


-- Q2: Find hierarchy of employees under a given manager
-- Q3: Find hierarchy of managers for a given employee