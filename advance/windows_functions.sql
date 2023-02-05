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



SELECT * FROM product


-- First Value: extract the column value for the first column inside a partition
-- Display the most expensive product under each category (corresponding to each record)

select *,
first_value(product_name) over(partition by product_category order by price desc) as most_expensive_product
from product;



-- Last Value: extract the column value for the last column inside a partition
-- Display the least expensive product under each category (corresponding to each record)
select *,
first_value(product_name) 
	over(partition by product_category order by price desc) as most_expensive_product,
last_value(product_name)
	over(partition by product_category order by price desc
		range between unbounded preceding and unbounded following) as least_expensive_product
from product
-- where product_category = 'Phone';


-- Alternate way to write SQL query using windows functions
select *,
first_value(product_name) 
	over w as most_expensive_product,
last_value(product_name)
	over w as least_expensive_product
from product
window w as (
	partition by product_category order by price desc
		range between unbounded preceding and unbounded following)




-- NTILE
-- Write a query to segregate all the expensive phones, mid range phones and the cheaper phones.
select x.product_name, 
case when x.buckets = 1 then 'Expensive Phones'
     when x.buckets = 2 then 'Mid Range Phones'
     when x.buckets = 3 then 'Cheaper Phones' END as Phone_Category
from (
    select *,
    ntile(3) over (order by price desc) as buckets
    from product
    where product_category = 'Phone') x;
