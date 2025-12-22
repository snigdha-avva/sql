select abs(-200);
 use dec12;
 select round(12.34567,2);
 select round(12.34467,2);
select ceil (12.34); -- 13
select ceil(-12.34); -- -12
select ceil(12.0); -- 12

select floor(12.34); -- 12
select floor(-12.34); -- -13
select floor(12.0); -- 12

select truncate(12.34567,2); -- 12.34
select truncate(12.34867,2); -- 12.34
select truncate(12.34267,2); -- 12.34

select mod(10,2); -- 10%2== 0 cz 10/2  rem = 0 
 select pow(2,5); -- 2^5=32
 select sqrt(64); -- 8
 select rand(); -- generates random number between 0 and 1
 
 select curdate(),current_date(); -- 2025-12-19	2025-12-19
 
 select curtime(),current_time(); -- 07:06:15	07:06:15
 
 select current_timestamp() -- 2025-12-19 07:06:59
 
 select now() -- 2025-12-19 07:07:20
 
 select sysdate() -- 2025-12-19 07:08:00
 
 select year(curdate()) -- 2025
  select year("2025-12-19") -- 2025
  select month(curdate()),day("2025-12-19") -- 12,19
  
  select hour("07:08:00"),minute("07:08:00"),second("07:08:00") -- 7,8,0
  
  select dayname(curdate()),dayname("2025-12-19") -- Friday	Friday
  
  select dayname("1996-06-25") -- Tuesday
  
  select dayofweek("1996-06-25") -- 3
  
  select weekday("1996-06-25") -- 1
  
  select adddate("2025-12-19",30) -- 2026-01-18
  select adddate("2025-12-19", interval 30 day) -- 2026-01-18
  select adddate("2025-12-19", interval 1 month) -- 2026-01-19
  select adddate("2025-12-19", interval 1 year) -- 2026-12-19
  
