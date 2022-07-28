--analysis.tmp_rfm_recency
with recency_metrics as (
	with ranks as (
	select user_id,
	rank() OVER(ORDER BY max(order_ts) ASC NULLS FIRST) as last_order_rnk
	from analysis.orders_view
	where status between 4 and 5
	group by user_id),
			rec_ranc as (
			select
	   			user_id,
	    		CASE
	       	 	WHEN ranks.last_order_rnk BETWEEN 1 AND 200 THEN 1
	        	WHEN ranks.last_order_rnk BETWEEN 201 AND 400 THEN 2
						WHEN ranks.last_order_rnk BETWEEN 401 AND 600 THEN 3
						WHEN ranks.last_order_rnk BETWEEN 601 AND 800 THEN 4
						WHEN ranks.last_order_rnk BETWEEN 801 AND 1000 THEN 5
	    			END AS recency_ranks
			from ranks)
	 				SELECT
	                	ranks.user_id,
	                	max(recency_ranks) as recency
	            	from ranks
	            	join rec_ranc
	        		on rec_ranc.user_id = ranks.user_id
	        		group by ranks.user_id
	)
insert into analysis.tmp_rfm_recency (user_id, recency)
select user_id, recency from recency_metrics
;
