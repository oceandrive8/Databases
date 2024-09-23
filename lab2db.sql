--1--
create database lab2;

--2--
create table countries(
    country_id serial primary key,
    country_name varchar,
    region_id int,
    population int
);

--3--
insert into countries
values(default, 'Japan', 2, 125100000);

--4--
insert into countries(country_id, country_name)
values (default, 'USA');

--5--
insert into countries(region_id)
values(NULL);

--6--
insert into countries
values(default, 'Korea', 410, 51630000);

--7--
alter table countries
    alter column country_name set default 'Kazakhstan';

--8--
insert into countries(country_name)
values(default);

--9--
insert into countries default values;

--10--
create table countries_new (like countries including all);

--11--
insert into countries_new select * from countries;

--12--
update countries
set region_id=1
where region_id is null;

--13--
select country_name, population*1.1 as "New population" from countries;

--14--
delete from countries
where population<100000;

--15--
delete from countries_new
where exists(select country_id
             from countries
             where countries.country_id=countries_new.country_id)
returning *;

--16--
delete from countries
returning *;






