use amazon;
-- 3- write a query to get total profit, first order date and latest order date for each category
select * from orders;
select category , min(order_date) as first_order_date ,
max(order_date) as latest_order_date 
, sum(sales) as total_sales
 from orders
  group by category 
  order by category ;
  
  -- 2- orders table can have multiple rows for a particular order_id when customers buys more than 1 product in an order.
-- write a query to find order ids where there is only 1 product bought by the customer.

 select order_id, count(*)
  from orders 
   group by order_id 
   having count(*)=1;
   
   
   -- 4- write a query to find sub-categories where average profit is more than the half of the max profit in that sub-category
   select sub_category 
    from orders
    group by sub_category
    having avg(profit)>max(profit)/2;
   -- 6- write a query to find total number of products in each category.
 select  category , count(product_id) as total_no_of_products
 from orders
  group by category;
  
  
  -- 7- write a query to find top 5 sub categories in west region by total quantity sold
  select region , category , sum(quantity) as total_quantity_sold 
   from orders
   where region ="west"
   group by region , category;
   
   -- 8- write a query to find total sales for each region and ship mode combination for orders in year 2020
    select region , ship_mode ,  sum(sales) as total_sales
     from orders 
     where year(order_date)="2020"
     group by region , ship_mode
     order by region, ship_mode;


-- 5- --- create the exams table with below script;
create database school;
use school;
create table exams (student_id int, subject varchar(20), marks int);

insert into exams values (1,'Chemistry',91),(1,'Physics',91),(1,'Maths',92)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80),(3,'Maths',80)
,(4,'Chemistry',71),(4,'Physics',54)
,(5,'Chemistry',79);

-- write a query to find students who have got same marks in Physics and Chemistry.
 select * from exams;
select  marks , student_id, count(*)
from exams
where subject in("physics" , "chemistry")
group by  marks , student_id;
 
 
 
 -- 13- write a query to create new column to categories orders in 4 category :

-- sales < 100  -> low value orders
-- sales < 200 --> medium value orders
-- sales <400 --> high value orders
-- sales >= 400  --> very hIgh value orders
use amazon;
 
 select category , sales ,
 case when  sales<100 then "low_value_orders"
when sales<200 then "medium_value_orders"
when sales <400 then "high_value_orders"
else "very_high_value_orders"  end  as  category_sales
from orders;

-- 12- orders table can have multiple rows for a particular order_id when customers buys more than 1 product in an order.
-- write a query to find order ids where there is more than 1 product bought by the customer. 
  
  select order_id , count(product_id) as no_of_product_bought
   from orders
     group by order_id
      having count(product_id)>1;


-- 9- write a query to print below 3 columns
-- category, total_sales_2019(sales in year 2019), total_sales_2020(sales in year 2020)

 select category ,
 sum( case when year(order_date)=2019 then sales end ) as  total_sales_2019,
 sum(case when year(order_date)=2020 then sales end) as total_sales_2020
  from orders
   group by category
   order by category;
   -- 11- the order_id column has made up of  following information : county-year-tranid,  eg:US-2021-152898 
-- write a query to get total sales by each county

  select order_id , sum(sales)as total_sales
   from orders
   group by order_id
   order by order_id ;
   
   -- 10- write a query to return first name and last name of a customer 
-- in 2 separate columns. Assume everything before first space is first name and rest is second name.

  SELECT customer_name ,
    SUBSTRING_INDEX(customer_name, ' ', 1) AS first_name,
    SUBSTRING(customer_name, LENGTH(SUBSTRING_INDEX(customer_name, ' ', 1)) + 2) AS last_name
FROM
    orders;

 




-- 1  write a query to get number of business days between order_date and ship_date (exclude weekends). 
-- Assume that all order date and ship date are on weekdays only.
select order_id , order_date , ship_date , datediff(ship_date , order_date) as days,
(extract(week from ship_date)- extract(week from order_date)) as weeks,
(datediff(ship_date , order_date)-2 * (extract(week from ship_date)- extract(week from order_date))) as business_days
from orders;