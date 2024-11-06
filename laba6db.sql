--1--
create database lab6;

--2--
create table locations(
    location_id serial primary key,
    street_address varchar(25),
    postal_code varchar(12),
    city varchar(30),
    state_province varchar(12)
);

create table departments(
    department_id serial primary key,
    department_name varchar(50) unique,
    budget integer,
    location_id integer references locations
);

create table employees(
    employee_id serial primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(50),
    phone_number varchar(20),
    salary integer,
    department_id integer references departments
);

--3--
select first_name, last_name, department_id, department_name
from employees
join departments USING (department_id);

--4--
select first_name,
       last_name,
       department_id,
       department_name
from employees
join
    departments USING (department_id)
where department_id=80 or department_id=40;

--5--
select
    first_name,
    last_name,
    department_name,
    city,
    state_province
from employees
join
    departments USING (department_id)
join
    locations USING (location_id);

--6--
select
    d.department_id,
    d.department_name,
    e.first_name,
    e.last_name
from
    departments d
left join
    employees e USING (department_id);

--7--
select
    employees.first_name,
    employees.last_name,
    employees.department_id,
    departments.department_name
from
    employees
left join
    departments USING (department_id);


--Example

INSERT INTO locations (street_address, postal_code, city, state_province) VALUES
('123 Main St', '12345', 'New York', 'NY'),
('456 Elm St', '67890', 'Los Angeles', 'CA'),
('789 Oak St', '13579', 'Chicago', 'IL'),
('101 Pine St', '24680', 'Houston', 'TX');

INSERT INTO departments (department_name, budget, location_id) VALUES
('Sales', 100000, 1),
('Marketing', 150000, 2),
('Development', 200000, 3),
('HR', 75000, 4);

INSERT INTO employees (first_name, last_name, email, phone_number, salary, department_id) VALUES
('John', 'Doe', 'john.doe@example.com', '555-1234', 60000, 1),
('Jane', 'Smith', 'jane.smith@example.com', '555-5678', 65000, 2),
('Emily', 'Jones', 'emily.jones@example.com', '555-8765', 70000, 1),
('Michael', 'Brown', 'michael.brown@example.com', '555-4321', 80000, NULL),  -- No department
('Sarah', 'Davis', 'sarah.davis@example.com', '555-1357', 72000, 3);
