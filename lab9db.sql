create database lab9;

--1--
create or replace function increase_value(
    in input_val integer,
    out increased_val integer
)
    as
$$
    begin
        select input_val+10 into increased_val;
    end;
$$
language plpgsql;

select(increase_value(5));




--2--
create or replace function compare_num(
    in n1 int,
    in n2 int,
    out res varchar
)
as
$$
begin
    if n1>n2 then
        select 'Greater' into res;
    elseif n1<n2 then
        select 'Lesser' into res;
    else
        select 'Equal' into res;
    end if;
end;
$$ language plpgsql;

select(compare_num(9,6));





--3--
create or replace function number_series(
    in n int,
    out res text
)
as $$
begin
    res:='';

    for i in 1..n loop
        res := res || i::TEXT;
    end loop;
end;
$$ language plpgsql;

select number_series(8);






--4--
create or replace function find_employee(
    in employee_name varchar
)
    returns table (
    employee__id int,
    employee_pos varchar(50),
    employee_city varchar(50),
    employee_salary numeric(10, 2),
    employee_department varchar(50)
)as $$
begin
    return query
    select employee_id, pos, city, salary, department
    from employees
    where name = employee_name;
end;
$$ language plpgsql;

select * from find_employee('john doe');



--for task 4--
create table employees (
    employee_id int,
    name varchar(100) not null,
    pos varchar(50),
    city varchar(50),
    salary numeric,
    department varchar(50)
);

insert into employees (employee_id,name, pos, city, salary, department)
values
(1,'john doe', 'manager', 'new york', 85000, 'hr'),
(2,'jane smith', 'developer', 'san francisco', 95000, 'it'),
(8,'emily davis', 'analyst', 'boston', 72000, 'finance'),
(15,'michael brown', 'designer', 'los angeles', 60000, 'marketing');







--5--
create or replace function list_products(
    in category_name varchar
)returns table (
    product__id int,
    p_name varchar(100),
    p_price numeric(10, 2),
    p_stock int,
    p_category varchar(50)
)as $$
begin
    return query
    select product_id, name, price, stock, category
    from products
    where category = category_name;
end;
$$ language plpgsql;

select * from list_products('Furniture');



--for task5--
create table products (
    product_id int,
    name varchar(100) not null,
    price numeric(10, 2),
    stock int,
    category varchar(50)
);

insert into products (product_id,name, price, stock, category)
values
(4,'Laptop', 1200.00, 10, 'Electronics'),
(123,'Smartphone', 800.00, 20, 'Electronics'),
(67,'Desk Chair', 150.00, 5, 'Furniture'),
(24,'Bookshelf', 200.00, 2, 'Furniture');





--6--
create or replace function calculate_bonus(
    salary integer
)
returns numeric
as
$$
begin
    return salary * 0.15;
end;
$$
language plpgsql;



create or replace function update_salary(
    in employeee_id numeric
)
    returns table(
        employeee_name varchar,
        updated_salary numeric
)
as
$$
declare
    cur_salary integer;
    bonus numeric;
begin

    select salary, name into cur_salary, employeee_name
    from employees
    where employee_id=employeee_id;

    bonus:=calculate_bonus(cur_salary);

    update employees
    set salary = salary + bonus
    where employee_id = employeee_id;

    select salary into updated_salary from employees
    where employee_id=employeee_id;
    return query
    select employeee_name, updated_salary;

end;
$$
language plpgsql;

select * from update_salary(2);





--7--
create or replace function complex_calculation(
    num integer,
    string varchar,
    out res varchar
)
as
$$
declare
    str_res varchar;
    num_res numeric;
    or_num numeric;
begin
    or_num:=num;
    <<num_block>>
    begin
        num_res := 1;
        while num > 0 loop
            num_res := num_res * num;
            num := num - 1;
        end loop;

    end num_block;

    <<string_block>>
    begin
        str_res := concat('reversed version of ', string, ' - ', reverse(string));
    end string_block;

    res:=concat(str_res, '       ||      ', 'factorial of ', or_num::varchar, ' is ', num_res);
end;
$$ language plpgsql;


select complex_calculation(3, 'blackpinksvt');

