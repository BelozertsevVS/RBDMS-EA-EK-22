CREATE DATABASE TEST1;

USE [TEST1];

GO

CREATE SCHEMA OBUKH; -- Ваше прізвище

GO


-- Create a simple table to demonstrate data types

CREATE TABLE OBUKH.DATATYPES (

ID BIGINT, -- Unique identifier of an entity

AGE TINYINT -- Number of years

);


INSERT INTO OBUKH.DATATYPES(ID, AGE)

VALUES(10000, 34);

INSERT INTO OBUKH.DATATYPES(ID, AGE)

VALUES(10001, 32);

-- Implicit data type conversion

INSERT INTO OBUKH.DATATYPES(ID, AGE)

VALUES('10002', 32);

-- Implicit data type conversion

INSERT INTO OBUKH.DATATYPES(ID, AGE)

VALUES('10003', '35');

-- Implicit data type conversion

INSERT INTO OBUKH.DATATYPES(ID, AGE)

VALUES('19700101', '35');

-- Let's take a look on the data

SELECT *

FROM OBUKH.DATATYPES;