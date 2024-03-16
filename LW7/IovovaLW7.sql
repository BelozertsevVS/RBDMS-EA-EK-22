--Створення денормалізованої таблиці:
CREATE TABLE Orders (
    OrderID INT,
    CustomerName VARCHAR(20),
    ProductName VARCHAR(50),
    ProductCategory VARCHAR(30),
    Quantity INT,
    UnitPrice SMALLMONEY,
    OrderDate DATETIME
);
ALTER TABLE Orders 
--Вставимо дані в нашу таблицю:
INSERT INTO Orders (OrderID, CustomerName, ProductName, ProductCategory, Quantity, UnitPrice, OrderDate)
VALUES
    (1, 'John Doe', 'Laptop', 'Electronics', 2, 1200.00, '2024-03-10'),
    (2, 'Jane Smith', 'Smartphone', 'Electronics', 1, 800.00, '2024-03-11'),
    (3, 'John Doe', 'Headphones', 'Electronics', 3, 100.00, '2024-03-12'),
    (4, 'Alice Johnson', 'Laptop', 'Electronics', 1, 1200.00, '2024-03-13'),
    (5, 'Bob Williams', 'Tablet', 'Electronics', 2, 500.00, '2024-03-14'),
    (6, 'Jane Smith', 'Tablet', 'Electronics', 1, 500.00, '2024-03-15'),
    (7, 'Alice Johnson', 'Smartphone', 'Electronics', 1, 800.00, '2024-03-16'),
    (8, 'Bob Williams', 'Smartwatch', 'Electronics', 1, 300.00, '2024-03-17'),
    (9, 'John Doe', 'Laptop', 'Electronics', 1, 600.00, '2024-03-18'),
    (10, 'Alice Johnson', 'Smartphone', 'Electronics', 2, 1100.00, '2024-03-19');

	--Потенційні проблеми денормалізованої таблиці включають:
--Дублювання даних, що може призвести до проблем з інтегритетом даних та важливістю змін.
--Зберігання неатомарних значень, що робить управління та аналіз даних більш складним.

--Створимо таблиці, які унікальні та містять атомарні значення полів:
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);
--Вставимо дані до таблиці:
INSERT INTO Customers(CustomerID, CustomerName)
VALUES
    (1, 'John Doe'),
    (2, 'Jane Smith'),
    (3, 'Alice Johnson'),
    (4, 'Bob Williams');

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    ProductCategory VARCHAR(50)
);

--Вставимо дані до таблиці:
INSERT INTO Products( ProductID, ProductName, ProductCategory)
VALUES
(1, 'Laptop','Electronics'),
(2,'Smartphone', 'Electronics'),
(3, 'Headphones', 'Electronics'),
(4, 'Tablet', 'Electronics'),
(5, 'Smartwatch', 'Electronics');

--Подивимося дані з наших таблиць:
SELECT * 
FROM [dbo].[Products];
SELECT * 
FROM [dbo].[Customers];

--Змінимо таблицю Orders:
-- Видалення зв'язаного стовпця CustomerName:
ALTER TABLE Orders DROP COLUMN CustomerName;

-- Додавання зв'язаного стовпця CustomerID:
ALTER TABLE Orders ADD CustomerID INT;

-- Оновлення зовнішнього ключа для відповідності новому стовпцю CustomerID:
ALTER TABLE Orders ADD CONSTRAINT FK_CustomerID FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID);

-- Звільнення стовпця ProductName:
ALTER TABLE Orders DROP COLUMN ProductName;

-- Додавання зв'язаного стовпця ProductID:
ALTER TABLE Orders ADD ProductID INT;

-- Оновлення зовнішнього ключа для відповідності новому стовпцю ProductID:
ALTER TABLE Orders ADD CONSTRAINT FK_ProductID FOREIGN KEY (ProductID) REFERENCES Products(ProductID);

--Додамо обмеження NOT NULL для таблиці Orders:
ALTER TABLE Orders ALTER COLUMN OrderID INT NOT NULL;
--Додамо головний ключ до таблиці Orders:
ALTER TABLE Orders ADD CONSTRAINT PK_OrderID PRIMARY KEY (OrderID);

--Розділимо дані на додаткові таблиці:
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice SMALLMONEY,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
--Вставимо дані:
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
VALUES
(1, 1, 2, 1200.00),
(2, 2, 1, 800.00),
(3, 3, 3, 100.00),
(4, 1, 1, 1200.00),
(5, 4, 2, 500.00),
(6, 4, 1, 500.00),
(7, 2, 1, 800.00),
(8, 5, 1, 300.00),
(9, 1, 1, 600.00),
(10, 2, 2, 1100.00);

--Перевіримо дані:
SELECT *
FROM [dbo].[OrderDetails];


--Bидаляємо транзитивні залежності:
-- Видаляємо залежність від ціни одиниці від загальної кількості:
-- Видалення та зміна зовнішніх ключів:
ALTER TABLE OrderDetails DROP CONSTRAINT FK_OrderID;
ALTER TABLE OrderDetails DROP CONSTRAINT FK_ProductID;

-- Додавання стовпців які будуть створювати зовнішні ключі
ALTER TABLE OrderDetails ADD CONSTRAINT FK_OrderID FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);
ALTER TABLE OrderDetails ADD CONSTRAINT FK_ProductID FOREIGN KEY (ProductID) REFERENCES Products(ProductID);

--Створюємо окрему таблицю для цін:
CREATE TABLE ProductPrices (
    ProductID INT PRIMARY KEY,
    UnitPrice SMALLMONEY,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
--Вставимо дані в таблицю:
INSERT INTO ProductPrices (ProductID, UnitPrice)
VALUES
(1, 500.00),
(2, 600.00),
(3, 33.33),
(4, 500.00),
(5, 200.00);
--Перевіримо дані:
SELECT *
FROM [dbo].[ProductPrices];

--Виконаємо запити для вставки, оновлення, та видалення даних в нормалізованій структурі:
--1.
INSERT INTO Orders (OrderID)
VALUES
(11);
--Перевіримо:
SELECT *
FROM [dbo].[Orders];
--Працює

--2.
UPDATE Products SET ProductName = 'PC' WHERE ProductID = 5;
--Перевіримо:
SELECT *
FROM [dbo].[Products];
SELECT *
FROM [dbo].[ProductPrices];
--Працює

--3.
DROP TABLE ProductPrices;
--Перевіримо:
SELECT *
FROM [dbo].[Products];
--Працює.
