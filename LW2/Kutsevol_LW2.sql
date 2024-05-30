﻿USE [WebStor];
GO
CREATE SCHEMA KUTSEVOL;   
GO



CREATE TABLE KUTSEVOL.DATATYPES (
       ID  BIGINT, -- Unique identifier of an entity
	   AGE TINYINT -- Number of years
);
INSERT INTO KUTSEVOL.DATATYPES(ID, AGE)
VALUES(10000, 34);

INSERT INTO KUTSEVOL.DATATYPES(ID, AGE)
VALUES(10001, 32);

-- Implicit data type conversion
INSERT INTO KUTSEVOL.DATATYPES(ID, AGE)
VALUES('10002', 32);

-- Implicit data type conversion
INSERT INTO KUTSEVOL.DATATYPES(ID, AGE)
VALUES('10003', '35');

-- Implicit data type conversion
INSERT INTO KUTSEVOL.DATATYPES(ID, AGE)
VALUES('19700101', '35');

-- Implicit data type conversion IS NOT WORKING!
INSERT INTO KUTSEVOL.DATATYPES(ID, AGE) 
VALUES(10004, DATEDIFF(YEAR, '1970-01-01', GETDATE()));

SELECT * 
  FROM KUTSEVOL.DATATYPES;