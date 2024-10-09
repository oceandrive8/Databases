--1--
create database lab4;

--2--
create table Warehouses(
    code serial primary key,
    location varchar(255),
    capacity int
);

create table Boxes(
    code char(4),
    contents varchar(255),
    value real,
    warehouse int
);

--3--
INSERT INTO warehouses(code,location,capacity) VALUES(default,'Chicago',3);
INSERT INTO warehouses(code,location,capacity) VALUES(default,'Chicago',4);
INSERT INTO warehouses(code,location,capacity) VALUES(default,'New York',7);
INSERT INTO warehouses(code,location,capacity) VALUES(default,'Los Angeles',2);
INSERT INTO warehouses(code,location,capacity) VALUES(default,'San Francisco',8);



INSERT INTO Boxes(code,contents,value,warehouse) VALUES('0MN7','Rocks',180,3);
INSERT INTO Boxes(code,contents,value,warehouse) VALUES('4H8P','Rocks',250,1);
INSERT INTO Boxes(code,contents,value,warehouse) VALUES('4RT3','Scissors',190, 4);
INSERT INTO Boxes(code,contents,value,warehouse) VALUES('7G3H','Rocks',200, 1);
INSERT INTO Boxes(code,contents,value,warehouse) VALUES('8JN6','Papers',75,1);
INSERT INTO Boxes(code,contents,value,warehouse) VALUES('8Y6U','Papers',50,3);
INSERT INTO Boxes(code,contents,value,warehouse) VALUES('9J6F','Papers',175,2);
INSERT INTO Boxes(code,contents,value,warehouse) VALUES('LL08','Rocks',140,4);
INSERT INTO Boxes(code,contents,value,warehouse) VALUES('P0H6','Scissors',125,1);
INSERT INTO Boxes(code,contents,value,warehouse) VALUES('P2T6','Scissors',150,2);
INSERT INTO Boxes(code,contents,value,warehouse) VALUES('TU55','Papers',90,5);

--4--
select * from warehouses;

--5--
select * from Boxes
where value>150;

--6--
select distinct on(contents) * from Boxes;

--7--
select warehouse, count(*) from Boxes
group by warehouse;

--8--
select warehouse, count(*) from Boxes
group by warehouse
having count(*)>2;

--9--
insert into warehouses(code, location,capacity) values (default,'New York', 3);

--10--
insert into Boxes(code, contents, value, warehouse) values('H5RT','Papers', 200,2);

--11--
update Boxes
set value=value*0.85
where value=(
    select value
    from Boxes
    order by value desc
    limit 1 offset 2
    );

--12--
delete from Boxes
where value<150;

--13--
delete from Boxes
where warehouse=(
    select code
    from warehouses
    where location='New York'
    )
returning *;