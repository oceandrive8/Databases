--1--
create database lab5;

--2--
create table salesman(
    salesman_id int primary key,
    name varchar(255),
    city varchar(255),
    commission double precision
);
create table customers(
    customer_id int,
    cust_name varchar(255),
    city varchar(255),
    grade int,
    salesman_id int,
    primary key(customer_id, salesman_id),
    foreign key (salesman_id) references salesman(salesman_id)
);
create table orders(
    ord_no int primary key,
    purch_amt double precision,
    ord_date DATE,
    customer_id int,
    salesman_id int,
    foreign key (customer_id, salesman_id) references customers(customer_id, salesman_id),
    foreign key (salesman_id) references salesman(salesman_id)
);




insert into salesman (salesman_id, name, city, commission) values
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', null, 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

insert into customers (customer_id, cust_name, city, grade, salesman_id) values
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', 0, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);

insert into orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) values
(70001, 150.50, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.50, '2012-08-17', 3009, 5003),
(70007, 948.50, '2012-09-10', 3005, 5002),
(70005, 2400.60, '2012-07-27', 3007, 5001),
(70008, 5760.00, '2012-09-10', 3002, 5001);


--3--
select sum(purch_amt) total_purch from orders;

--4--
select avg(purch_amt) avg_purch from orders;

--5--
select count(*) amount
from customers where cust_name is not null;

--6--
select min(purch_amt) minimum from orders;

--7--
select * from customers where cust_name like '%b';

--8--
select * from orders
where customer_id in (select customer_id
                   from customers
                   where city='New York');

--9--
select * from customers
where (customer_id) in (
    select customer_id
    from orders
    where purch_amt>10
    );

--10--
select sum(grade) total_g from customers;

--11--
select * from customers
where cust_name is not null;

--12--
select max(grade) max_g from customers;
