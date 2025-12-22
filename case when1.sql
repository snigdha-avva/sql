create database dec12;
use dec12;
show databases;
create table student(
id int,
name varchar(20),
age int
);

show tables;

insert into student(id,name,age) values (6,"niyu",34);

select * from student;

insert into student values (2,"vijay",32),(3,"jay",45),(4,"Anjali",45);

insert into student(id,name) values (5,"sam");

alter table student add grade int;

alter table student add (
class int,
school varchar(20)
);

desc student;
alter table student modify school varchar(40);

alter table student modify grade varchar(1);
#adding default value ;

alter table student modify school varchar(40) default "VTS";
insert into student values(7,"abhi",41,"A",4);

alter table student rename column school to school_name;

select * from students;

alter table student rename to students;

alter table students drop column school_name;

drop table student

insert into students values(8,"abhis",41,"A",4),(9,"abhimanyu",41,"A",4),(10,"abhishek",41,"A",4);

update students set name = "niyotha" where id = 7

0	38	06:59:39	update students set name = "niyotha" where id = 41	Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column. 
 To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.	0.000 sec
 
 delete from students where grade = "A"
 
 create table pension(
id int,
name varchar(20),
age int
);

select * from pension;
insert into pension values(1,"abhis",41),(2,"abhimanyu",56),(3,"abhishek",41);

select id,name,age,
case
when age>55 then "eligible"
else "not eligible"
end as status
from pension;

CREATE TABLE Employee (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    experience INT,
    performance_rating CHAR(1)
);

select * from Employee;

INSERT INTO Employee (emp_id, emp_name, department, salary, experience, performance_rating) 
VALUES 
(1, 'Alice', 'HR', 55000, 5, 'A'),
(2, 'Bob', 'Engineering', 95000, 7, 'B'),
(3, 'Charlie', 'Engineering', 72000, 3, 'C'),
(4, 'David', 'Marketing', 50000, 6, 'A'),
(5, 'Eva', 'Finance', 78000, 10, 'B'),
(6, 'Frank', 'HR', 62000, 8, 'C'),
(7, 'Grace', 'Finance', 85000, 9, 'A');

select * from employee where salary >50000 and performance_rating = "A";

select * from employee where salary >50000 or performance_rating = "A";
-- #1	If performance is 'A':
-- o	For salaries above 80,000, experience above 5 years gets a 25% hike, otherwise 20%.
-- o	For salaries between 50,000 and 80,000, the hike is 15%.
-- •	If performance is 'B':
-- o	For experience above 5 years, the hike is 12%.
-- o	Otherwise, it's 10%.
-- •	For performance 'C', there is no hike.
select *,
case 
	when performance_rating = "A" then
			case
				when salary > 80000 and experience>5 then '25% hike'
                when salary between 50000 and 80000 then '15% hike'
                else '20%'
            end
    when performance_rating = "B" then
			case
				when experience>5 then '12% hike'
                else '10%'
            end        
    when performance_rating = "C" then '0% hike'
end  as bonus  
from employee;


-- Problem 3: Categorizing Employees by Salary Range and Performance
-- Scenario: You want to categorize employees based on salary ranges and their performance:
-- •	If salary is greater than 80,000 and performance is 'A', label them as High Performer.
-- •	If salary is between 50,000 and 80,000 and performance is 'B', label them as Mid Performer.
-- •	If salary is less than 50,000 or performance is 'C', label them as Low Performer.

select  *,case
when salary > 80000 and performance_rating = "A" then "High Performer"
when salary between 50000 and 80000 and performance_rating = "B" then "Mid Performer"
when salary < 80000 and performance_rating = "C" then "Low Performer"
end as performance
from employee

-- Problem 4: Risk Assessment Based on Experience and Department
-- Scenario: You want to assess employee risk based on their experience and department:
-- •	For employees in the HR department:
-- o	If experience is less than 5 years, they are High Risk.
-- o	If experience is more than 5 years, they are Low Risk.
-- •	For employees in Engineering or Finance departments:
-- o	If experience is more than 8 years, they are Low Risk.
-- o	If experience is less than 8 years, they are Medium Risk.
-- •	Employees in other departments are automatically labeled Medium Risk.

select *, 
case 
	when department = "HR" then 
				case
					when experience < 5 then "High Risk"
                    when experience > 5 then "Low Risk"
                end
    when department = "Engineering" or department = "Finance" then 
				case
					when experience > 8 then "Low Risk"
                    when experience < 8 then "Medium Risk"
                end
    else "Medium Risk"            
end  as risk_level
from employee

-- Problem 1: Nested CASE for Performance and Salary Hike Based on Multiple Criteria
-- Scenario: You want to determine the salary hike based on performance rating, experience, and current salary. The hike rules are:
-- •	If performance is 'A':
-- o	For salaries above 80,000, experience above 5 years gets a 25% hike, otherwise 20%.
-- o	For salaries between 50,000 and 80,000, the hike is 15%.
-- •	If performance is 'B':
-- o	For experience above 5 years, the hike is 12%.
-- o	Otherwise, it's 10%.
-- •	For performance 'C', there is no hike.

select *,
case 
	when performance_rating = "A" then
			case
				when salary > 80000 and experience>5 then '25% hike'
                when salary between 50000 and 80000 then '15% hike'
                else '20%'
            end
    when performance_rating = "B" then
			case
				when experience>5 then '12% hike'
                else '10%'
            end        
    when performance_rating = "C" then '0% hike'
end  as bonus  
from employee;

-- 2.Department and Performance
-- Scenario: You are tasked with giving bonuses based on the department, performance rating, and experience:
-- •	For Finance department:
-- o	If performance is 'A' and experience is more than 10 years, bonus is 25% of salary.
-- o	Otherwise, bonus is 20%.
-- •	For HR department:
-- o	If performance is 'B' or experience is greater than 5 years, the bonus is 15%.
-- o	Otherwise, the bonus is 10%.
-- •	For other departments, the bonus is 8%.


CREATE TABLE CustomerUsage (
 customer_id INT PRIMARY KEY,
 customer_name VARCHAR(50),
 plan_type VARCHAR(20),
 data_used_gb INT,
 call_minutes INT,
 monthly_bill DECIMAL(10,2)
);

INSERT INTO CustomerUsage VALUES
(1, 'Veena', 'Postpaid', 9, 471, 842.03),
(2, 'Veer', 'Postpaid', 7, 354, 434.94),
(3, 'Mohan', 'Prepaid', 33, 497, 569.23),
(4, 'Pratik', 'Prepaid', 15, 113, 1107.48),
(5, 'Farhan', 'Prepaid', 14, 1284, 845.75),
(6, 'Jiya', 'Postpaid', 28, 1578, 1325.15);

select * from CustomerUsage

select * ,case 
when plan_type = 'Prepaid' then case
								when monthly_bill > 800  then case
                                                                 when call_minutes > 1000 then case
                                                                                                   when data_used_gb < 10 then 'Switch to Voice Add-on'
                                                                                                   when data_used_gb > 25 then 'Switch to Postpaid Premium Plan'
                                                                                                   else 'Upgrade to Postpaid Base Plan'
																								end
                                                                 else 'Recharge Reduction Advised'
															  end
                                else 'Current Plan OK'
                                end
when plan_type = 'Postpaid' then case
                                     when data_used_gb <10 then case
                                                                    when monthly_bill >700 then 'Switch to Lower Postpaid Plan'
                                                                    else 'Satisfactory Plan'
                                                                end
                                     when data_used_gb>25 then case
                                                               when call_minutes<500 then 'Consider Data-Only Plan'
                                                               else 'Premium User Verified'
															   end
                                     else 'No Change Needed'
    
                                  end
end as status
from CustomerUsage
