create table employee(
    emp_id int,
    emp_name varchar(20),
    dept_id int,
    salary int,
    manager_id int,
    emp_age int
);


insert into employee values(1,'Ankit',100,10000,4,39);
insert into employee values(2,'Mohit',100,15000,5,48);
insert into employee values(3,'Vikas',100,10000,4,37);
insert into employee values(4,'Rohit',100,5000,2,16);
insert into employee values(5,'Mudit',200,12000,6,55);
insert into employee values(6,'Agam',200,12000,2,14);
insert into employee values(7,'Sanjay',200,9000,2,13);
insert into employee values(8,'Ashish',200,5000,2,12);
insert into employee values(9,'Mukesh',300,6000,6,51);
insert into employee values(10,'Rakesh',500,7000,6,50);
select * from employee;

create table dept(
    dep_id int,
    dep_name varchar(20)
);
insert into dept values(100,'Analytics');
insert into dept values(200,'IT');
insert into dept values(300,'HR');
insert into dept values(400,'Text Analytics');
select * from dept;
select * from employee

select * from orders
select * from returns

--1- write a query to get region wise count of return orders.

select o.region, count(distinct r.order_id)
from orders o
inner join returns r on r.order_id=o.order_id
group by o.region

--2- write a query to get category wise sales of orders that were not returned.
select o.category,sum(distinct sales) as total_sale
from orders o
left join returns r on o.order_id =r.order_id
where r.order_id is null
group by o.category

--3- write a query to print dep name and average salary of employees in that dep .
select * from dept
select * from employee
select d.dep_name, avg(distinct e.salary) as avg_salary
from dept d
inner join employee e on e.dept_id=d.dep_id
group by d.dep_name

--4- write a query to print dep names where none of the emplyees have same salary.
select d.dep_name
from dept d
inner join employee e on e.dept_id=d.dep_id
group by d.dep_name
having count(e.salary)=count(distinct e.salary)

--5- write a query to print sub categories where we have all 3 kinds of returns (others,bad quality,wrong items)


select o.sub_category,count(distinct r.return_reason) as reason
from orders o
inner join returns r on o.order_id=r.order_id
group by o.sub_category
having count(distinct r.return_reason)=3 

--6- write a query to find cities where not even a single order was returned.
select * from orders
select o.city,r.order_id
from orders o
left join returns r on r.order_id=o.order_id
group by o.city,r.order_id
having count(r.order_id)=0
order by o.city

select * from returns

select o. *,r.order_id as r_order_id,return_reason
from orders o
left join  returns r on o.order_id=r.order_id
order by o.city


--7- write a query to find top 3 subcategories by sales of returned orders in east region

select top 3 o.sub_category,sum(o.sales) as return_sales
from orders o 
inner join returns r on r.order_id=o.order_id
where region='East'
group by o.sub_category
order by return_sales desc

--8- write a query to print dep name for which there is no employee
select * from dept
select * from employee

select e.*, d.dep_id as d_dep_id,d.dep_name
from employee e
right join dept d on d.dep_id=e.dept_id

select d.dep_name,d.dep_id
from dept d
left join employee e on e.dept_id=d.dep_id
group by d.dep_name,d.dep_id
having count( e.emp_id)=0

--9- write a query to print employees name for dep id is not avaiable in dept table
select e.*, d.dep_id as d_dep_id,d.dep_name
from employee e
left join dept d on d.dep_id=e.dept_id

select e.emp_name,d.dep_id
from employee e
left join dept d on e.dept_id=d.dep_id
group by e.emp_name,d.dep_id
having count (d.dep_id)=0







