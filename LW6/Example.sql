-- DATA CONSTRAINTS

-- NOT NULL
-- PRIMARY KEY
-- FOREIGN KEY
-- UNIQUE
-- CHECK
-- DEFAULT

CREATE DATABASE SILPO;

USE SILPO;

-- PRIMARY KEY (1-й спосіб додати PK)
CREATE TABLE Products (
ProductID INT PRIMARY KEY, 
Title     NVARCHAR(100)
); 

-- 1) В стовбці зберігаються тільки унікальні значення
-- 2) В стовбці не можуть міститись значення NULL
-- 3) Таблиця повинна мати тільки один первинний ключ
-- 4) Первинний ключ може бути композитним 


INSERT INTO Products ([ProductID])
VALUES (3);

SELECT *
FROM [dbo].[Products];


-- PRIMARY KEY (2-й спосіб додати PK)
CREATE TABLE Products (
ProductID INT NOT NULL, 
Title     NVARCHAR(100)
); 

ALTER TABLE Products ADD CONSTRAINT PK_ProductID PRIMARY KEY (ProductID);  



-- FOREIGN KEY 
-- 1) Втановлює відношення між двома таблицями
-- 2) Забезпечується посилальна цілісність
-- 3) Можливі операції каскадного оновлення або видалення

-- FOREIGN KEY (1-й варіант додавання FK)

CREATE TABLE Produts_On_Warehouse (
WarehouseID INT PRIMARY KEY,
Product     INT,
Quantity    INT,
FOREIGN KEY (Product) REFERENCES Products (ProductID)
ON DELETE CASCADE
ON UPDATE CASCADE
);



-- FOREIGN KEY (2-й варіант додавання FK)
ALTER TABLE Produts_On_Warehouse ADD CONSTRAINT FK_Product 
FOREIGN KEY (Product) REFERENCES Products (ProductID);

INSERT INTO Produts_On_Warehouse ([WarehouseID], [Product], [Quantity])
VALUES (2, 2, 25);



-- UNIQUE
ALTER TABLE [dbo].[Products] ADD CONSTRAINT UQ_Title UNIQUE([Title]);

-- CHECK
CREATE TABLE Employees (
EmployeeID INT PRIMARY KEY,
[Name] NVARCHAR(100),
AGE INT CHECK (AGE >= 18)
)

INSERT INTO Employees ([EmployeeID], [Name], [AGE])
VALUES (2, 'Іван', 17);

-- DEFAULT

CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
OrderDate DATE DEFAULT GETDATE() 
)
;

INSERT INTO Orders ([OrderID])
VALUES (2);


SELECT *
FROM [dbo].[Orders];


SELECT *
FROM [dbo].[Employees];

SELECT *
FROM [dbo].[Products];

SELECT *
FROM [dbo].[Produts_On_Warehouse];



TRUNCATE TABLE [dbo].[Products];

DELETE FROM  [dbo].[Products]
WHERE [ProductID] = 1;

DROP TABLE [dbo].[Produts_On_Warehouse];


