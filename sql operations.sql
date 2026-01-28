-- except/minus --remove common between two tables but remove duplicate between one table.
-- union all-- all records ,duplicate values also
--union -- remove duplicate
--intersect -- common values in both tables.

create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');
select * from icc_world_cup

--1- write a query to produce below output from icc_world_cup table.
--team_name, no_of_matches_played , no_of_wins , no_of_losses


with all_teams as 
(select Team_1 as team, case when Team_1=Winner then 1 else 0 end as win_flag from icc_world_cup
union all
select Team_2 as team, case when Team_2=Winner then 1 else 0 end as win_flag from icc_world_cup)
select team,count(1) as total_matches_played , sum(win_flag) as matches_won,count(1)-sum(win_flag) as matches_lost
from all_teams
group by team

--2- write a query to print first name and last name of a customer using orders table(everything after first space can be considered as last name)
--customer_name, first_name,last_name
select * from orders
select customer_name ,trim(substring(customer_name,1,charindex(' ',customer_name))) as first_name,
substring(customer_name,charindex(' ',customer_name)+1,len (customer_name)-charindex(' ',customer_name)+1)as second_name
from orders

--Run below script to create drivers table:

create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));
insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');

--3- write a query to print below output using drivers table.
--Profit rides are the no of rides where end location of a ride is same as start location of immediate next ride for a driver
--id, total_rides , profit_rides
--dri_1,5,1
--dri_2,2,0

select * from drivers
select d1.*,d2.*
from drivers d1
inner join drivers d2 on d1.id=d2.id
where d1.end_loc=d2.start_loc and d1.end_time=d2.start_time

select d1.id as driver_id, count(1) as total_rides,count(d2.id) as profit_rides
from drivers d1
left join drivers d2 on d1.id=d2.id and d1.end_loc=d2.start_loc and d1.end_time=d2.start_time
group by d1.id

--4- write a query to print customer name and no of occurence of character 'n' in the customer name.
--customer_name , count_of_occurence_of_n
select customer_name,len(customer_name)-len(replace(lower(customer_name),'n','')) as count_of_occurence_of_n from orders

--5-write a query to print below output from orders data. example output
--hierarchy type,hierarchy name ,total_sales_in_west_region,total_sales_in_east_region
--category , Technology, ,
--category, Furniture, ,
--category, Office Supplies, ,
--sub_category, Art , ,
--sub_category, Furnishings, ,
--and so on all the category ,subcategory and ship_mode hierarchies.
select * from orders
select 'category' as hierarchy_type,category as hierarchy_name,
sum(case when region ='West' then sales else 0 end) as total_sales_in_west_region,
sum(case when region ='East' then sales else 0 end) as total_sales_in_east_region
from orders 
group by category
union all
select 'sub_category' as hierarchy_type,sub_category as hierarchy_name,
sum(case when region ='West' then sales else 0 end) as total_sales_in_west_region,
sum(case when region ='East' then sales else 0 end) as total_sales_in_east_region
from orders 
group by sub_category
union all
select 'ship_mode' as hierarchy_type,ship_mode as hierarchy_name,
sum(case when region ='West' then sales else 0 end) as total_sales_in_west_region,
sum(case when region ='East' then sales else 0 end) as total_sales_in_east_region
from orders 
group by ship_mode









--6- the first 2 characters of order_id represents the country of order placed . write a query to print total no of orders placed in each country
--(an order can have 2 rows in the data when more than 1 item was purchased in the order but it should be considered as 1 order)

select * from orders

select left(order_id,2)as country, count(distinct order_id) as total_number_of_orders from orders
group by left(order_id,2)



