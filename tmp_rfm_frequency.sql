--analysis.tmp_rfm_frequency
with frequency_metrics as (
with cl_ords as (
select user_id,
ROW_NUMBER() OVER(ORDER BY COUNT(orders_view.order_id) ASC NULLS FIRST) AS closed_orders
from  analysis.orders_view
where status between 4 and 5
group by user_id
),
   	fre as (
	select user_id,case
	when closed_orders between 1 and 200 then 1
	when closed_orders between 201 and 400 then 2
	when closed_orders between 401 and 600 then 3
	when closed_orders between 601 and 800 then 4
	when closed_orders between 801 and 1000 then 5
	end as frequency
	from cl_ords)
		select fre.user_id,max(frequency) as frequency
		from  analysis.orders_view o
		join cl_ords on cl_ords.user_id=o.user_id
		join fre on fre.user_id=o.user_id
		group by fre.user_id)
insert into analysis.tmp_rfm_frequency (user_id ,frequency)
select user_id ,frequency from frequency_metrics
;
