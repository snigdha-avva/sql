use dec12;

select subdate("2025-12-21",30) -- 2025-11-20

select date_sub(now(),interval 7 day) -- 2025-12-14 06:36:03

select timestampdiff(year,"2025-12-20","2024-12-20")
select timestampdiff(month,"2025-12-20","2024-12-20")
select timestampdiff(day,"2025-12-20","2024-12-20")
select timestampdiff(hour,"2025-12-20 7:35:43","2024-12-20 7:35:43")
select timestampdiff(minute,"2025-12-20 7:35:43","2024-12-20 7:35:43")
select timestampdiff(second,"2025-12-20 7:35:43","2024-12-20 7:35:43")

select date_format("2025-12-20",'%Y %M %D') -- 2025 December 20th
select date_format("2025-12-20",'%y %m %d') -- 25 12 20

CREATE TABLE employee_payments (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    base_salary DECIMAL(10,2),
    bonus DECIMAL(10,2),
    joining_date DATE
);

INSERT INTO employee_payments VALUES
(1,'karthik','Data',75000.75,5000.50,'2019-03-15'),
(2,'veena','HR',65000.40,4000.25,'2021-06-20'),
(3,'ravi','Data',85000.90,6000.75,'2016-01-10'),
(4,'anil','Finance',70000.10,NULL,'2020-09-01'),
(5,'suresh','HR',60000.55,3000.30,'2022-11-25');

CREATE TABLE orders_delivery (
    order_id INT,
    customer_name VARCHAR(50),
    order_date DATE,
    delivery_date DATE,
    order_amount DECIMAL(10,2)
);

INSERT INTO orders_delivery VALUES
(101,'rajesh','2025-01-01','2025-01-05',12500.75),
(102,'meena','2025-01-10','2025-01-10',8400.40),
(103,'arun','2025-01-15','2025-01-20',15600.90),
(104,'pooja','2025-01-18',NULL,9200.10);

-- Question
-- For each order:
-- Uppercase customer name
-- Calculate delivery days using date difference
-- Replace NULL delivery date with today
-- Truncate order amount to 1 decimal
-- Use CASE:
-- Same-day
-- Delayed (>3 days)
-- Pending

select  
order_id,
upper(customer_name) as customer_name,
timestampdiff(day,order_date,delivery_date) as date_difference,
ifnull(delivery_date,curdate()),
truncate(order_amount,1),
case
when delivery_date = order_date then 'same_day'
when timestampdiff(day,order_date,delivery_date) >3 then 'Delayed'
else 'pending'
end as order_status
from orders_delivery