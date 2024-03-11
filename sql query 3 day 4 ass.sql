use amazon;
-- 1- write a query to get region wise count of return orders
select * from orders;
select * from returns;
select  o.region as region, count(r.order_id) as no_of_return_order
 from orders as o
 inner join 
 returns as r on o.order_id=r.order_id
 group by region
 order by region;
 
 -- 2- write a query to get category wise sales of orders that were not returned
  select o.category , sum(sales) as total_sales
   from orders as o
   left  join returns as r
   on o.order_id = r.order_id
   where r.order_id  is null
   group by category
   order by category;
   
   
 
 -- 3- write a query to print dep name and average salary of employees in that dep .
 
   select  d.dep_name as department_name , avg(salary) as average_salary
     from employee as e
     inner join dept as d
     on e.dep_id =d.dep_id
      group by  d.dep_name;
      
      
	-- 4- write a query to print dep names where none of the emplyees have same salary.

 use xyz;
select d.dep_name
from employee e
inner join dept d on e.dep_id=d.dep_id
group by d.dep_name
having count(e.emp_id)=count(distinct e.salary);





-- 5- write a query to print sub categories where we have all 3 kinds of returns (others,bad quality,wrong items)



select o.sub_category , count(distinct r.return_reason) as all_3_kinds_of_return
from orders o
inner join returns r on o.order_id=r.order_id
group by o.sub_category 
  having count(distinct r.return_reason)=3;




-- 6- write a query to find cities where not even a single order was returned.

    select o.city  , count( r.order_id) as not_a_single_order
    from orders as o
    left join  returns  as r
    on o.order_id=r.order_id
    group by o.city
     having count(r.order_id)=0;
 
 
 -- 7- write a query to find top 3 subcategories by sales of returned orders in east region.
  select o.sub_category , sum(o.sales) as  total_returned_sales
   from orders as o
  inner join returns as r on o.order_id =r.order_id 
   where o.region='east' and return_reason in('others','bad quality','wrong items')
    group by o.sub_category
    order by total_returned_sales desc
    limit 3;

    
    
    -- 8- write a query to print dep name for which there is no employee
select d.dep_id , d.dep_name
 from dept as d 
 left join  employee as e on d.dep_id = e.dep_id 
 where e.dep_id  is null;
 
 -- 9- write a query to print employees name where dep id is not avaiable in dept table
  select   e.dep_id , e.emp_name 
   from employee as e
   left join  dept as d
   on e.dep_id = d.dep_id 
   where d.dep_id is null;
   
   -- 10-write a query to print emp name , their manager name and diffrence in their age for employees whose age is less then their manager's age.
    select e1.emp_name as emp_name , e1.emp_age as emp_age ,
    e2.emp_name as manager_name , e2.emp_age as manager_age , (e2.emp_age - e1.emp_age) as age_diff
    from employee as e1 
    inner join employee as e2 
    on e1.manager_id= e2.manager_id 
     where e1.emp_age < e2.emp_age ;
     
     
     
     
     
-- 11-write a query to print emp name, manager name and senior manager name (senior manager is manager's manager).
select e.emp_name as emp_name , m.emp_name as manager_name , s.emp_name as senior_manager_name 
 from employee as e
 inner join employee as m
 on  e.manager_id = m.emp_id 
 inner join employee as s
 on m.manager_id = s.emp_id;