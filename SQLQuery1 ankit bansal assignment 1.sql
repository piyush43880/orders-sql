use  namaste_sql;
 
-- 1- write a sql to get all the orders where customers name has "a" as second character and "d" as fourth character (58 rows).
select * from orders where customer_name like '_a_d%';
--2- write a sql to get all the orders placed in the month of dec 2020 (352 rows) 
select * from orders where year(order_date)='2020' and month(order_date)='12';
--3- write a query to get all the orders where ship_mode is neither in 'Standard Class' nor in 'First Class' and ship_date is after nov 2020 (944 rows).
select * from orders where ship_mode not in('Standard Class','First Class') and  ship_date >'2020-11-30';

--4- write a query to get all the orders where second character of customer name is not i and customer name ends with "n" (2097 rows)
select * from orders where customer_name 
not like '_i%' and customer_name like '%n';
-- 5- write a query to get all the orders where profit is negative (1871 rows)
select * from orders where 
profit <0;
-- 6- write a query to get all the orders where either quantity is less than 3 or profit is 0 (3348)
select * from orders 
where quantity <3 or profit=0;
--your manager handles the sales for South region and he wants you to create a report of all the orders in his region where some discount is provided to the customers (815 rows)
select * from orders where region='south' and discount>0;
-- 8- write a query to find top 5 orders with highest sales in furniture category 
select top 5
* from orders
where
category ='furniture'
order by sales desc;
-- 9- write a query to find all the records in technology and furniture category for the orders placed in the year 2020 only (1021 rows)
select * from orders
where category in('technology' , 'furniture')
and year(order_date)=2020;

-- 10-write a query to find all the orders where order date is in year 2020 but ship date is in 2021 (33 rows)
 select * from orders 
 where year(order_date)='2020' and year(ship_date)='2021';
 select * from orders
  where order_date between '2020-01-01' and '2020-12-31' and ship_date between '2021-01-01' and '2021-12-31';
--11- write a update statement to update city as null for order ids :  CA-2020-161389 , US-2021-156909
 update orders set city=null where order_id ='CA-2020-161389';
 update orders set city=null where order_id ='US-2021-156909';
 --12- write a query to find orders where city is null (2 rows)
 select * from orders where city is null;