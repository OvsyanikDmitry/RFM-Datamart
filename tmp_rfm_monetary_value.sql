--analysis.tmp_rfm_monetary_value
with monetay_metrics as (
with total_pay as (
select user_id,
ROW_NUMBER() OVER(ORDER BY SUM(orders_view.payment) ASC NULLS FIRST) AS total_p
from  analysis.orders_view
where status between 4 and 5
group by user_id
),
	mon as (
	select user_id,
	case
	when total_p between 1 and 200 then 1
	when total_p between 201 and 400 then 2
	when total_p between 401 and 600 then 3
	when total_p between 601 and 800 then 4
	when total_p between 801 and 1000 then 5
	end as monetary
	from total_pay)
		select
		mon.user_id,
		max(monetary) as monetary
		from  analysis.orders_view o
		join total_pay on total_pay.user_id=o.user_id
		join mon on mon.user_id=o.user_id
		group by mon.user_id
	)
insert into analysis.tmp_rfm_monetary_value (user_id, monetary_value)
select user_id, monetary from monetay_metrics
;
