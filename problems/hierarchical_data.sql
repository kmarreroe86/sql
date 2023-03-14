-- Find hierarchy of employees.
-- For each employee, showcase all the employee's working under them (includin themselves). Such that, when the child tree expands, every new employee
-- should be dynamically assigned to their managers till the top level hierarchy
-- Url: https://www.youtube.com/watch?v=LZGaRcDxj8I


DROP TABLE IF EXISTS employee_hierarchy;
CREATE TABLE employee_hierarchy
( 
    emp_id int,
    reportind_id int
);

insert into employee_hierarchy values
(1, null),
(2, 1),
(3, 1),
(4, 2),
(5, 2),
(6, 3),
(7, 3),
(8, 4),
(9, 4);
commit;

-- Answer:

SELECT emp_id, reportind_id	FROM public.employee_hierarchy;

with recursive cte as
(
	select emp_id, emp_id as emp_hierarchy
	from employee_hierarchy
	union all
	select cte.emp_id, eh.emp_id as emp_hierarchy
	from cte join employee_hierarchy eh on cte.emp_hierarchy = eh.reportind_id
)

select * from cte order by emp_id, emp_hierarchy;