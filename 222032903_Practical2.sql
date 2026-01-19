create database organisation_employee;
go
use organisation_employee;
go 

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    job_name VARCHAR(20),
    manager_id INT,
    hire_date DATE,
    salary DECIMAL(10,2),
    commission DECIMAL(10,2),
    dep_id INT
);
go

INSERT INTO employees (emp_id, emp_name, job_name, manager_id, hire_date, salary, commission, dep_id) VALUES
(68319, 'KAYLING', 'PRESIDENT', NULL, '1991-11-18', 6000.00, NULL, 1001),
(66928, 'BLAZE', 'MANAGER', 68319, '1991-05-01', 2750.00, NULL, 3001),
(67832, 'CLARE', 'MANAGER', 68319, '1991-06-09', 2550.00, NULL, 1001),
(65646, 'JONAS', 'MANAGER', 68319, '1991-04-02', 2957.00, NULL, 2001),
(67858, 'SCARLET', 'ANALYST', 65646, '1997-04-19', 3100.00, NULL, 2001),
(69062, 'FRANK', 'ANALYST', 65646, '1991-12-03', 3100.00, NULL, 2001),
(63679, 'SANDRINE', 'CLERK', 69062, '1990-12-18', 900.00, NULL, 2001),
(64989, 'ADELYN', 'SALESMAN', 66928, '1991-02-20', 1700.00, 400.00, 3001),
(65271, 'WADE', 'SALESMAN', 66928, '1991-02-22', 1350.00, 600.00, 3001),
(66564, 'MADDEN', 'SALESMAN', 66928, '1991-09-28', 1350.00, 1500.00, 3001),
(68454, 'TUCKER', 'SALESMAN', 66928, '1991-09-08', 1600.00, 0.00, 3001),
(68736, 'ADNRES', 'CLERK', 67858, '1997-05-23', 1200.00, NULL, 2001),
(69000, 'JULIUS', 'CLERK', 66928, '1991-12-03', 1050.00, NULL, 3001),
(69324, 'MARKER', 'CLERK', 67832, '1992-01-23', 1400.00, NULL, 1001);
 go 

 select distinct e.emp_id,e.emp_name,e.job_name,e.dep_id from employees e
where e.emp_id in (select manager_id from employees where manager_id is not null)
and e.manager_id <> (select emp_id from employees where job_name = 'PRESIDENT')

select emp_id,emp_name,job_name,dep_id from employees 
where job_name in(select job_name from employees where emp_name in ('SANDRINE','ADELYN'))
and emp_name not in ('SANDRINE','ADELYN')

select emp_name,dep_id from employees e 
where salary =(select MAX(salary)from employees where dep_id = e.dep_id)

select distinct job_name from employees
where dep_id = 1001
and job_name not in (select distinct job_name from employees where dep_id = 2001)

select * from employees
where dep_id = 1001 
and salary >(select avg(salary) from employees where dep_id = 2001)