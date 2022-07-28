# 1.3. Качество данных


Данные в таблицах я смотрел в DBeaver через базу данных в свойствах таблиц.
Дополнительно я открыл диаграмму схемы production, чтобы лучше понять структуру схемы.
Данные нормальные для необходимых расчетов. Только данные за 2022-02 2022-03, в условии задачи необходимо составить витрину из данных за 2021 год.
Возможно это опечатка? Если да, то данные полностью подходят для задачи.
Единственное в таблице пользователей перепутаны местами имена и логины.
В задаче эта таблица не нужна, поэтому это не критично.



| Таблицы             | Объект                      | Инструмент      | Для чего используется |
| ------------------- | --------------------------- | --------------- | --------------------- |
| production.Products | id int4 NOT NULL PRIMARY KEY | Первичный ключ  | Обеспечивает уникальность записей о пользователях |
| production.Products | name varchar(2048) NOT NULL |                 | Наименование продукции,слишком большое значение varchar|
| production.Products | price numeric(19,5) NOT NULL| CHECK           | Ограничивает цену, цена только > 0|

| production.orders   | order_id int4 NOT NULL PRIMARY KEY | Первичный ключ  | Обеспечивает уникальность записей о заказах |
| production.orders   | order_ts timestamp NOT NULL |                 |
| production.orders   | user_id  int4  NOT NULL     |                 |
| production.orders   | bonus_payment numeric(19,5) NOT NULL|по умолчанию 0|
| production.orders   | payment numeric(19,5) NOT NULL|по умолчанию 0 |
| production.orders   | cost numeric(19,5) NOT NULL | CHECK по умолчанию 0|стоимость=платеж+бонус
| production.orders   | bonus_grant numeric(19,5) NOT NULL|по умолчанию 0|
| production.orders   | status  int4 NOT NULL       |                 |

| production.orderitems | id int4 NOT NULL PRIMARY KEY | Первичный ключ, автоувеличение  | Обеспечивает уникальность записей о комплектации заказов|
| production.orderitems | product_id NOT NULL| UNIQUE KEY                                |
| production.orderitems | order_id NOT NULL  | UNIQUE KEY                                |
| production.orderitems | name varchar(2048)|                                            |
| production.orderitems | price numeric(19,5)|CHECK по умолчанию 0                       |цена >=0
| production.orderitems | discount numeric(19,5)| по умолчанию 0                         |
| production.orderitems | quantity int4| CHECK                                           | количество больше нуля         

| production.orderstatuses | id int4 NOT NULL PRIMARY KEY | Первичный ключ  | Обеспечивает уникальность записей о статусах |
| production.orderstatuses | id varchar(255) NOT NULL     |                 | Наименование статусов |

| production.orderstatuslog | id int4 NOT NULL PRIMARY KEY | Первичный ключ  | Обеспечивает уникальность  логов                  |
| production.orderstatuslog | order_id int4 NOT NULL UNIQUE KEY |            |                                                   |
| production.orderstatuslog | status_id int4 NOT NULL UNIQUE KEY |           |                                                   |
| production.orderstatuslog | dttm timestamp NOT NULL  |                     | время статуса в логе                              |

| production.users | id int4 NOT NULL PRIMARY KEY | Первичный ключ  | Обеспечивает уникальность записей о пользователях |
| production.users | name varchar(2048) NULLABLE  |                 | в именах логины |
| production.users | login varchar(2048) NOT NULL |                 | в логинах имена |
