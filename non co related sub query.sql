create database mydb
use mydb
show tables

CREATE TABLE employees (
id INT,
first_name VARCHAR(50),
department VARCHAR(50),
city VARCHAR(50),
salary INT
);
INSERT INTO employees VALUES
(1,'Rahul','IT','Delhi',60000),
(2,'Priya','HR','Hyderabad',45000),
(3,'Arjun','Finance','Mumbai',55000),
(4,'Sneha','IT','Pune',65000),
(5,'Vikram','Finance','Chennai',52000),
(6,'Kavya','HR','Kochi',48000),
(7,'Manoj','IT','Noida',70000),
(8,'Anita','Finance','Nagpur',60000),
(9,'Ravi','HR','Bangalore',47000),
(10,'Divya','IT','Lucknow',58000);

-- 1.Employees earning more than overall average salary

select * from employees where salary > (
select avg(salary) from employees
);

-- 2. Employees earning the maximum salary in the company

select * from employees where salary = (
select max(salary) from employees
);

-- 3. Employees working in the same city as the highest-paid employee

select * from employees where city = (select city from employees where salary = (
select max(salary) from employees
));


-- Employees in departments where minimum salary > 50000

select * from employees where department in (
select department from employees group by department having min(salary) > 50000
);

-- 6. Employees whose salary is among top 3 salaries

select * from employees where salary in (
select * from(
select distinct salary from employees order by salary desc limit 3
) as sub );


-- 7. Employees in departments with total salary > 150000

select * from employees where department in (
select department from employees group by department having sum(salary) > 150000
);

-- 8 Employees earning less than minimum salary in IT department

select * from employees where salary < (
select min(salary) from employees where department = 'IT'
);

-- 9 Employees earning more than 2nd highest salary in Finance

select * from employees where salary > (
SELECT salary
FROM (
  SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
  FROM employees where department = 'Finance'
) t
WHERE rnk = 2);

-- 10 employees working in cities having at least 2 employees
 
 select * from employees where city in (
 select city from employees group by city having count(city) >= 2
 );
 
 select city,count(*) from employees group by city
 
 



