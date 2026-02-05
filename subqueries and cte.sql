--1- write a query to find premium customers from orders data. Premium customers are those who have done more orders than average no of orders per customer.

select * from orders
with cte as(select customer_id,count(distinct order_id) as total_orders from orders
group by customer_id)
select * from cte where
total_orders > (select  avg(total_orders ) from cte)



--2- write a query to find employees whose salary is more than average salary of employees in their department
select e.* from employee e
inner join 
(select dept_id,avg(salary) as avg_salary 
from employee
group by dept_id) d 
on e.dept_id=d.dept_id
where salary>avg_salary

--3- write a query to find employees whose age is more than average age of all the employees.

select * from employee where emp_age>
(select avg(emp_age) as avg_age
from employee
) 


--4- write a query to print emp name, salary and dep id of highest salaried employee in each department 

select * from
(select emp_name,salary,dept_id,
dense_rank() over (partition by dept_id order by salary desc) as rn
from employee)a
where rn =1
order by dept_id

select e.* from employee e
inner join (select dept_id,max(salary) as max_sal from employee group by dept_id)  d
on e.dept_id=d.dept_id
where salary=max_sal


--5- write a query to print emp name, salary and dep id of highest salaried overall

select emp_name,salary,dept_id
from employee
where salary=(select max(salary) from employee)



--6- write a query to print product id and total sales of highest selling products (by no of units sold) in each category
select * from orders

with cte as(
select category,product_id,sum(quantity) as total_quantity
from orders group by category,product_id),

cte_max_quantity  as(
select  category,max(total_quantity) as max_quantity
from cte group by category)

select * from cte cte
inner join cte_max_quantity cmq on cte.category=cmq.category
where cte.total_quantity=cmq.max_quantity

--7- https://www.namastesql.com/coding-problem/8-library-borrowing-habits

Imagine you're working for a library and you're tasked with generating a report on the borrowing habits of patrons. You have two tables in your database: Books and Borrowers.

 

Write an SQL to display the name of each borrower along with a comma-separated list of the books they have borrowed in alphabetical order, display the output in ascending order of Borrower Name.

 

Tables: Books
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| BookID      | int         |
| BookName    | varchar(30) |
| Genre       | varchar(20) |
+-------------+-------------+

Tables: Borrowers
+--------------+-------------+
| COLUMN_NAME  | DATA_TYPE   |
+--------------+-------------+
| BorrowerID   | int         |
| BorrowerName | varchar(10) |
| BookID       | int         |
+--------------+-------------+
Hints
Expected Output
+--------------+-----------------------------------------+                  
| BorrowerName | BorrowedBooks                           |
+--------------+-----------------------------------------+
| Alice        | Pride and Prejudice,The Great Gatsby    |
| Bob          | Romeo and Juliet,To Kill a Mockingbird  |
| Charlie      | 1984,The Notebook                       |
| David        | The Catcher in the Rye,The Hunger Games |
| Eve          | Pride and Prejudice                     |
| Frank        | Foundation,Romeo and Juliet             |
| Grace        | The Notebook                            |
| Harry        | To Kill a Mockingbird                   |
| Ivy          | 1984                                    |



SELECT 
    b.BorrowerName, 
    GROUP_CONCAT(bk.BookName ORDER BY bk.BookName SEPARATOR ',') AS BorrowedBooks  --    Concatenate borrowed book names ordered alphabetically, separated by commas
FROM 
    Borrowers b                                                                    --    Borrowers table alias 'b'
    INNER JOIN Books bk ON b.BookID = bk.BookID                                   --    Join Books table on matching BookID to get book details
GROUP BY 
    b.BorrowerName                                                                --    Group results by each borrower
ORDER BY 
    b.BorrowerName ASC;                                                            --    Order borrowers alphabetically by name ascending



--8- https://www.namastesql.com/coding-problem/52-loan-repayment

--You're working for a large financial institution that provides various types of loans to customers. Your task is to analyze loan repayment data to assess credit risk and improve risk management strategies.

Write an SQL to create 2 flags for each loan as per below rules. Display loan id, loan amount , due date and the 2 flags.

 

1- fully_paid_flag: 1 if the loan was fully repaid irrespective of payment date else it should be 0.
2- on_time_flag : 1 if the loan was fully repaid on or before due date else 0.
Table: loans
+-------------+-----------+
| COLUMN_NAME | DATA_TYPE |
+-------------+-----------+
| loan_id     | int       |
| customer_id | int       |
| loan_amount | int       |
| due_date    | date      |
+-------------+-----------+
Table: payments
+--------------+-----------+
| COLUMN_NAME  | DATA_TYPE |
+--------------+-----------+
| amount_paid  | int       |
| loan_id      | int       |
| payment_date | date      |
| payment_id   | int       |
+--------------+-----------+

select l.loan_id,l.loan_amount,l.due_date,
case when sum(p.amount_paid)= l.loan_amount  then 1 else 0 end as fully_paid_flag,
case when sum(case when p.payment_date<=l.due_date then p.amount_paid end) =l.loan_amount then 1 else 0  end as on_time_flag
from loans l
left join payments p on l.loan_id=p.loan_id
group by l.loan_id,l.loan_amount,l.due_date
order by l.loan_id

loan_id | loan_amount | due_date   | fully_paid_flag | on_time_flag |
+---------+-------------+------------+-----------------+--------------+
|       1 |        5000 | 2023-01-15 |               0 |            0 |
|       2 |        8000 | 2023-02-20 |               1 |            1 |
|       3 |       10000 | 2023-03-10 |               0 |            0 |
|       4 |        6000 | 2023-04-05 |               1 |            1 |
|       5 |        7000 | 2023-05-01 |               1 |            0 |
|       6 |        9000 | 2023-06-01 |               1 |            1 |
|       7 |       12000 | 2023-06-10 |               0 |            0 |
|       8 |       15000 | 2023-07-01 |               0 |            0 |
|       9 |        5000 | 2023-07-15 |               0 |            0 |
|      10 |       11000 | 2023-08-01 |               0 |            0 |
|      11 |        7000 | 2023-08-10 |               0 |            0 |
|      12 |        9000 | 2023-08-15 |               0 |            0 |
|      13 |       13000 | 2023-09-01 |               0 |            0 |
|      14 |        6000 | 2023-09-10 |               0 |            0 |
|      15 |        7500 | 2023-09-15 |               0 |            0 |
|      16 |        8200 | 2023-10-01 |               0 |            0 |
|      17 |        9500 | 2023-10-10 |               0 |            0 |
|      18 |       14000 | 2023-10-20 |               0 |            0 |
|      19 |        5000 | 2023-11-01 |               0 |            0 |
|      20 |       10500 | 2023-11-15 |               0 |            0 |
+---------+-------------+------------+-----------------+--------------+
--You own a small online store, and want to analyze customer ratings for the products that you're selling. After doing a data pull, you have a list of products and a log of purchases. Within the purchase log, each record includes the number of stars (from 1 to 5) as a customer rating for the product.

For each category, find the lowest price among all products that received at least one 4-star or above rating from customers.
If a product category did not have any products that received at least one 4-star or above rating, the lowest price is considered to be 0. The final output should be sorted by product category in alphabetical order.

Table: products
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| category    | varchar(10) |
| id          | int         |
| name        | varchar(20) |
| price       | int         |
+-------------+-------------+
Table: purchases
+-------------+-----------+
| COLUMN_NAME | DATA_TYPE |
+-------------+-----------+
| id          | int       |
| product_id  | int       |
| stars       | int       |
+-------------+-----------+
Hints
Expected Output
+----------+-------+
| category | price |
+----------+-------+
| apple    |     0 |
| banana   |     8 |
| cherry   |    36 |
| grape    |     0 |
| orange   |    14 |
+----------+-------+

select p.category ,
coalesce(min(case when pr.product_id is not null then price end),0) as price
from products p
join purchases pr on p.id=pr.product_id and pr.stars in(4,5)
group by p.category
order by p.category

 
