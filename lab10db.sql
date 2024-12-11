create database lab10;

--creating tables--
create table books(
    book_id int primary key,
    title varchar(200),
    author varchar(200),
    price decimal(10,2),
    quantity int
);


create table customers(
    customer_id int primary key,
    name varchar(200),
    email varchar(200)
);


create table orders(
    order_id int primary key,
    book_id int,
    customer_id int,
    order_date date,
    quantity int,
    foreign key(book_id) references books(book_id),
    foreign key(customer_id) references customers(customer_id)
);


insert into books (book_id, title, author, price, quantity) VALUES
                                                                (1,'Database 101', 'A.Smith', 40.00,10),
                                                                (2,'Learn SQL', 'B.Johnson',35.00, 15),
                                                                (3,'Advanced DB', 'C.Lee', 50.00,5);

insert into customers(customer_id, name, email) VALUES
                                                    (101, 'John Doe', 'johndoe@example.com'),
                                                    (102, 'Jane Doe', 'janedoe@example.com');




--1--
begin;
insert into orders(order_id, book_id, customer_id, order_date, quantity) VALUES
                                                                           (4,1,101,'2024-12-09',2);
update books
set quantity=quantity-2
where book_id=1;
commit;

select * from orders where order_id=4;
select * from books where book_id=1;




--2--
do $$
begin
    if (select quantity from books where book_id=3)>=10 then
        insert into orders(order_id, book_id, customer_id, order_date, quantity)
        values (5, 3, 102, '2024-12-09', 10);

        update books
        set quantity = quantity - 10
        where book_id = 3;

        commit;
    else
        rollback;
    end if;
end $$;

select * from orders where order_id=5;
select * from books where book_id=3;




--3--
set transaction isolation level read committed;
begin;
update books
set price=45.00
where book_id=1;

select price from books where book_id=1;

set transaction isolation level read committed;
begin;
select price from books where book_id=1;
select price from books where book_id=1;
commit;



--4--
begin;
update customers
set email='john.doe8@example.com'
where customer_id=101;
commit;

select * from customers where customer_id=101;
