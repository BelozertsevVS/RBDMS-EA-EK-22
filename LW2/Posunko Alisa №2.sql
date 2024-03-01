USE [WebStor];
GO
CREATE SCHEMA POSUNKO;
go

create table POSUNKO.DATATYPES (
id bigint,
age tinyint
);
insert into POSUNKO.DATATYPES(id, age)
values(10000, 34);
insert into POSUNKO.DATATYPES(id, age)
values(10001, 32);
insert into POSUNKO.DATATYPES(id, age)
values('10002', 32);
insert into POSUNKO.DATATYPES(id, age)
values('10003', '35');
insert into POSUNKO.DATATYPES(id, age)
values('19700101', '35');
insert into POSUNKO.DATATYPES(id, age)
values('1970-01-01', '35');
SELECT *
FROM POSUNKO.DATATYPES;
