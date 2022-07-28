--analysis.dm_rfm_segments
insert into analysis.dm_rfm_segments (user_id,recency,frequency,monetary_value)
select distinct o.user_id,
r.recency as recency,
f.frequency as frequency,
m.monetary_value as monetary_value
from  analysis.orders_view o
inner join analysis.tmp_rfm_recency r
on o.user_id=r.user_id
inner join analysis.tmp_rfm_frequency f
on o.user_id=f.user_id
inner join analysis.tmp_rfm_monetary_value m
on o.user_id=m.user_id;

--первые 10 строк витрины
select user_id,recency,frequency,monetary_value
from analysis.dm_rfm_segments
order by 1
limit 10;

--вывод запроса
0	5	5	5
1	5	4	4
2	5	3	3
3	5	3	2
4	5	4	2
5	5	5	5
6	4	2	2
7	5	1	2
8	5	1	2
9	5	3	2

/*можно было во время вставки данных в витрину,
отсортировать по user_id,
а затем вывести 10 строк
*/
