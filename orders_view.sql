
CREATE or REPLACE VIEW analysis.orders_view AS
with last_status_id as (
            select order_id,max(dttm)as dttm ,max(status_id) as status_id
            from analysis.orderstatuslog_view
            group by order_id)
	                   SELECT o.order_id,o.order_ts,o.user_id,o.bonus_payment,o.payment,
	                   o.cost,o.bonus_grant,os.status_id as status
	                   FROM production.orders o
	                   INNER JOIN last_status_id os
	                   ON o.order_id = os.order_id
	                   and o.status=os.status_id
