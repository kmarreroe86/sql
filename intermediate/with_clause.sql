--*** With clause ***--
-- Fetch employees whor earn more than average salary of all employees

with avg_salary (avg_sal) as
	(select avg(salary) from employee)

select * 
from employee, avg_salary av
where salary > av.avg_sal



--*** Find stores with sales better than the average sales accross all sotres ***--

-- Steps:
-- 1 Find total sales per store Total_Sales
select name, sum(price) as total_sales_per_store
from sales
group by name;

-- 2 Find average sales with respect all the stores Avg_Sales
select cast(avg (total_sales_per_store) as int) as average_sales_for_all_stores
from (
	select name, sum(price) as total_sales_per_store
	from sales
	group by name
) x

-- 3 Find stores with sales bigger than average amoung all stores Total_Sales > Avg_Sales
select *
from
(
	select name, sum(price) as total_sales_per_store
	from sales
	group by name
) as total_sales
join
(
	select cast(avg (total_sales_per_store) as int) as average_sales_for_all_stores
	from (
		select name, sum(price) as total_sales_per_store
		from sales
		group by name
	) x
) as avg_sales
on total_sales.total_sales_per_store > avg_sales.average_sales_for_all_stores


-- Using the Wiht clause
with Total_Sales (name, total_sales_per_store) as 
		(select name, sum(price) as total_sales_per_store
		from sales
		group by name),
	Avg_Sales (average_sales_for_all_stores) as
		(select cast(avg (total_sales_per_store) as int) as average_sales_for_all_stores
		from Total_Sales)
		
select * 
from Total_Sales as ts
join Avg_Sales as av
on ts.total_sales_per_store > av.average_sales_for_all_stores