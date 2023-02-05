create table random_tbl (id int, val decimal);

insert into random_tbl
select 1, random() from generate_series(1, 10000000);

insert into random_tbl
select 2, random() from generate_series(1, 10000000)


select count(1) from random_tbl;

select id, avg(val), count(*)
from random_tbl
group by id;

-- Creating the view
create materialized view mv_random_tbl
as
select id, avg(val), count(*)
from random_tbl
group by id;

select * from mv_random_tbl;


-- Refreshing materialized view
delete from random_tbl where id = 1;
select * from mv_random_tbl;

refresh materialized view mv_random_tbl; -- update the data stored in mv_random_tbl
select * from mv_random_tbl;
