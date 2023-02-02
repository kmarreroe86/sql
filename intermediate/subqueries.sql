-- select * from department;
-- select * from employee;



--*** Find employees who's salary is more the average earned by all employees ***--

-- (Scalar Subquery) select avg(salary) from employee -- 87600.000000000000
-- Ex 1
select emp.* from employee emp
where emp.salary > (
	select avg(salary) from employee
)

-- Ex 2
select * from employee e
join (select avg(salary) sal from employee) avg_sal on  e.salary > avg_sal.sal;



--*** Find the employees who earn the highest salary in each deparment ***--
-- (Multiple Rows Subquery, multiple rows and columns)

select d.id, d.name, max(e.salary) as max_sal
from department d
inner join employee e on d.id = e.department_id
group by d.id, d.name; -- subquery


select e.name, e.salary
from employee e
where (e.department_id, e.salary) in
(
	select d.id, max(e.salary) as max_sal
	from department d
	inner join employee e on d.id = e.department_id
	group by d.id, d.name
);

-- Find deparment which doesn't have any employee
-- (Multiple Rows Subquery, single row and multiple columns)

select distinct e.department_id from employee e -- subquery

select d.* from department d 
where d.id not in
(
	select distinct e.department_id from employee e
)
















