with expected as
(
select 'observations_table' as tbl, 30514 as row_count UNION ALL 
select 'pharma_records' as tbl, 16270399 as row_count 

)
, observed as
(
select 'observations_table' as tbl, count(*) as row_count from observations_table UNION ALL 
select 'pharma_records' as tbl, count(*) as row_count from pharma_records

)
select
exp.tbl
, exp.row_count as expected_count
, obs.row_count as observed_count
, case
	when exp.row_count = obs.row_count
	then 'PASSED'
	else 'FAILED'
	end as ROW_COUNT_CHECK
from expected exp
inner join observed obs
	on exp.tbl=obs.tbl
	order by exp.tbl;

