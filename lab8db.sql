--1--
create database lab8;


--2--
create table salesman(
    salesman_id integer primary key,
    name text,
    city text,
    commission float
);

create table customers(
    customer_id integer primary key,
    cust_name text,
    city text,
    grade integer,
    salesman_id integer,
    foreign key(salesman_id) references salesman(salesman_id)
);

create table orders(
    ord_no integer primary key,
    purch_amt float,
    ord_date date,
    customer_id integer,
    salesman_id integer,
    foreign key(customer_id) references customers(customer_id),
    foreign key(salesman_id) references salesman(salesman_id)
);

insert into salesman (salesman_id, name, city, commission) values
    (5001, 'James Hoog', 'New York', 0.15),
    (5002, 'Nail Knite', 'Paris', 0.13),
    (5005, 'Pit Alex', 'London', 0.11),
    (5006, 'Mc Lyon', 'Paris', 0.14),
    (5003, 'Lauson Hen', NULL, 0.12),
    (5007, 'Paul Adam', 'Rome', 0.13);

insert into customers(customer_id, cust_name, city, grade, salesman_id) values
    (3002, 'Nick Rimando', 'New York', 100, 5001),
    (3005, 'Graham Zusi', 'California', 200, 5002),
    (3001, 'Brad Guzan', 'London', null,5005),
    (3004, 'Fabian Johns', 'Paris', 300,5006),
    (3007, 'Brad Davis', 'New York', 200,5001),
    (3009,'Geoff Camero', 'Berlin',100,5003),
    (3008, 'Julian Green', 'London', 300, 5002);

insert into orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) values
    (70001, 150.5,'2021-10-05', 3005,5002),
    (70009, 270.65, '2012-09-10', 3001,5005),
    (70002, 65.26, '2012-10-05',3002,5001),
    (70004, 110.5,'2012-08-17',3009, 5003),
    (70007, 948.5, '2012-07-27', 3007,5001),
    (70005, 2400.6, '2012-07-27', 3007, 5001),
    (70008, 5760, '2012-09-10', 3002, 5001);


--3--
create role junior_dev login;


--4--
create view view_salesmen as
    select salesman_id, name, commission
    from salesman
    where city='New York';

select * from view_salesmen;


--5--
create view view_s_c as
    select o.ord_no,
           s.name,
           c.cust_name
    from orders o
    join salesman s on o.salesman_id=s.salesman_id
    join customers c on o.customer_id=c.customer_id;

grant all privileges on view_s_c to junior_dev;


--6--
create view view_customers as
    select customer_id,
           cust_name
    from customers
    where grade=(select grade from customers order by grade desc limit 1);

grant select on view_customers to junior_dev;


--7--
create view view_city as
    select count(salesman_id)
    from salesman
    group by city;



--8--
create view view_m_one_c as
    select s.salesman_id,
           s.name,
           count(c.customer_id)
    from salesman s
    join customers c on s.salesman_id = c.salesman_id
    group by s.salesman_id, s.name
    having count(c.customer_id)>1;

select * from view_m_one_c;


--9--
create role intern;
grant junior_dev to intern with admin option;



