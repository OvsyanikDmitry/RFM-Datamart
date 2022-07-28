create or replace view analysis.orders_view as
select * from production.orders;

create or replace  view analysis.products_view as
select * from production.products;

create or replace  view analysis.orderitems_view as
select * from production.orderitems;

create or replace  view analysis.orderstatuslog_view as
select * from production.orderstatuslog;

create or replace  view analysis.orderstatuses_view as
select * from production.orderstatuses;

create or replace  view analysis.users as
select * from production.users;

select * from analysis.orders_view;
select * from analysis.products_view;
select * from analysis.orderitems_view;
select * from analysis.orderstatuslog_view;
select * from analysis.orderstatuses_view;
select * from analysis.users;
/*
drop view analysis.orders_view;
drop view analysis.products_view;
drop view analysis.orderitems_view;
drop view analysis.orderstatuslog_view;
drop view analysis.orderstatuses_view;
driop view analysis.users;
*/
