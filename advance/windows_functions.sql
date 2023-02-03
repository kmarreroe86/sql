-- Fetch the data and calculate the max salary but no as an aggregate function
select e.*, max(salary) over() as max_salary
from employee e


-- Find the max salary for each gender
select e.*, max(salary) over(partition by gender) as max_salary
from employee e


-- row_number()
-- generate unique identifier for each row
select e.*, row_number() over() as rn
from employee e

-- generate sequence of identifier for each gender
select e.*, row_number() over(partition by gender) as rn
from employee e

-- Get the first 2 employees by gender with more income
select * from (
	select e.*, row_number() over(partition by gender order by salary desc) as rn
		from employee e ) x
where x.rn < 3


-- rank()
-- Fetch the top employees in each gender earning the max salary
select e.*, 
rank() over (partition by gender order by salary desc) as rnk
from employee e

-- Top 3 by gender
select * from 
(select e.*, 
rank() over (partition by gender order by salary desc) as rnk
from employee e ) x
where x.rnk < 4







