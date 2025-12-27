use mydb

-- 9. Employees earning more than highest salary in HR department
select * from employees where salary > (select max(salary) from employees where department = 'HR');

scalar subquery
===============
CREATE TABLE employees1 (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    experience_years INT,
    hire_date DATE
);

INSERT INTO employees1 VALUES
(1, 'Amit', 'IT', 70000, 4, '2020-01-10'),
(2, 'Neha', 'HR', 45000, 6, '2019-03-15'),
(3, 'Ravi', 'IT', 85000, 8, '2018-07-21'),
(4, 'Sita', 'Finance', 60000, 3, '2021-06-11'),
(5, 'Karan', 'HR', 52000, 5, '2020-12-01'),
(6, 'Pooja', 'Finance', 90000, 10, '2017-09-30');

select * from employees1

delete from employees1 where hire_date is null

1
Fetch employees whose salary is greater than the overall average salary of all employees.

select * from employees1 where salary > (select avg(salary) from employees1 )
________________________________________
2
Retrieve employees whose salary is equal to the maximum salary present in the table.

select * from employees1 where salary = (select max(salary) from employees1 )

________________________________________
3
Find employees whose experience_years is less than the minimum experience recorded in the company.

select * from employees1 where experience_years < (select min(experience_years) from employees1 )
________________________________________
4
Display employees whose hire_date is later than the earliest hire date in the company.

select * from employees1 where hire_date > (select min(hire_date) from employees1 )

________________________________________
5
Fetch employees whose salary is greater than the total salary of all employees divided by the total number of employees.

select * from employees1 where salary > (select sum(salary)/count(emp_id) from employees1 )



CREATE TABLE employees2 (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    experience_years INT,
    hire_date DATE
);

INSERT INTO employees2 VALUES
(1, 'Amit', 'IT', 70000, 4, '2020-01-10'),
(2, 'Neha', 'HR', 45000, 6, '2019-03-15'),
(3, 'Ravi', 'IT', 85000, 8, '2018-07-21'),
(4, 'Sita', 'Finance', 60000, 3, '2021-06-11'),
(5, 'Karan', 'HR', 52000, 5, '2020-12-01'),
(6, 'Pooja', 'Finance', 90000, 10, '2017-09-30'),
(7, 'Rahul', 'IT', 75000, 7, '2019-09-05'),
(8, 'Anita', 'HR', 48000, 4, '2021-02-20'),
(9, 'Meena', 'Finance', 65000, 6, '2018-11-11'),
(10, 'Vikram', 'IT', 72000, 5, '2020-05-18');
________________________________________

select * from employees2

1.
Fetch employees whose salary matches any salary in the HR department.

select * from employees1 where salary = any (select salary from employees1 where department = 'HR' )

________________________________________
2.
Retrieve employees whose salary is NOT in the set of salaries of employees in the IT department.

select * from employees1 where salary not in (select salary from employees1 where department = 'IT' )

________________________________________
3.
Find employees whose experience_years is greater than ANY experience_years of employees in the Finance department.

select * from employees1 where experience_years > any (select experience_years from employees1 where department= 'Finance')

________________________________________
4.
Display employees whose salary is less than ALL salaries in the IT department.

select * from employees1 where salary < all (select salary from employees1 where department = 'IT' )
________________________________________
5.
Fetch employees whose hire_date matches any hire_date of employees in the HR department.

select * from employees2 where hire_date = any (select hire_date from employees1 where department = 'HR' )

________________________________________
6.
Retrieve employees whose salary is greater than ANY salary in the Finance department.

select * from  employees2 where salary > any (select salary from employees2 where department = 'Finance' )
________________________________________
7.
Find employees whose experience_years is less than ALL experience_years of employees in the IT department.

select * from employees2 where experience_years < all (select experience_years from employees2 where department= 'Finance')

____________________________________________________________________________________________________________________________
8.
Display employees whose salary is NOT equal to any salary of employees in the Finance department.

select * from employees2 where salary != any (select salary from employees2 where department= 'Finance')

________________________________________
9.
Fetch employees whose experience_years is greater than any experience_years of employees hired before 2020.

select * from employees2 where experience_years > any (select experience_years from employees2 where date_format(hire_date,'%Y') < 2020 )

________________________________________
10.
Retrieve employees whose hire_date is later than ALL hire_dates of employees in the HR department.

select * from employees2 where hire_date > all (select hire_date from employees2 where department = 'HR' )





