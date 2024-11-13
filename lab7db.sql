--1--
explain analyze
select *
from countries
where name='string';

create index ind on countries(name);



--2--
explain analyze
select *
from employees
where name='string' and surname='string';

create index index_employees_name on employees(name, surname);



--3--
explain analyze
select *
from employees
where salary<148900 and salary>65000;

create index index_employees_salary on employees(salary);



--4--
explain analyze
select *
from employees
where substring(name from 1 for 4)='abcd';

create index index_employees_substring on employees((substring(name from 1 for 4)));


--5--
explain analyze
SELECT * FROM employees e JOIN departments d
ON d.department_id = e.department_id WHERE
d.budget > 100000 AND e.salary < 2500000;

create index index_for_employees on employees(department_id, salary);
create index index_for_departments on departments(budget);


















--Example--
CREATE TABLE countries (
    name VARCHAR(50)
);

create table departments(
    department_id serial primary key,
    department_name varchar(50) unique,
    budget integer
);
create table employees(
    employee_id serial primary key,
    name varchar(50),
    surname varchar(50),
    email varchar(50),
    phone_number varchar(20),
    salary integer,
    department_id integer references departments
);

