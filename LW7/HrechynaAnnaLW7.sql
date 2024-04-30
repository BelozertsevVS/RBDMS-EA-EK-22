--Частина 1
--Створюємо денормалізовану таблицю
CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
CustomerName NVARCHAR(100),
ProductName NVARCHAR(100),
ProductCategory NVARCHAR(50),
Quantity INT,
UnitPrice DECIMAL(10),
OrderDate DATE);

--Внесемо дані у таблицю
INSERT INTO [dbo].[Orders](OrderID, CustomerName, ProductName, ProductCategory, Quantity, UnitPrice, OrderDate)
VALUES
(1, 'Лідія', 'Пральна машинка', 'Побутова техніка', 1, 8000, '2024.04.09'),
(2, 'Анастасія', 'Мікрохвильова піч', 'Побутова техніка', 1, 2000, '2024.04.09'),
(3, 'Лідія', 'Холодильник', 'Побутова техніка', 1, 10000, '2024.04.08'),
(4, 'Владислав', 'Пральна машинка', 'Побутова техніка', 1, 9000, '2024.04.08'),
(5, 'Софія', 'Мультипіч', 'Побутова техніка', 2, 5000, '2024.04.08'),
(6, 'Дмитро', 'Кухонний блендер', 'Побутова техніка', 1, 1000, '2024.04.07'),
(7, 'Дмитро', 'Електрочайник', 'Побутова техніка', 2, 600, '2024.04.06'),
(8, 'Богдан', 'Мікрохвильова піч', 'Побутова техніка', 1, 5000, '2024.04.05'),
(9, 'Юрій', 'Посудомийна машинка', 'Побутова техніка', 1, 11000, '2024.04.05'),
(10, 'Катерина', 'Мультипіч', 'Побутова техніка', 1, 4000, '2024.04.05');

SELECT*FROM [dbo].[Orders]

--Денормалізовані таблиці можуть призводити до проблем з аномаліями вставки, оновлення та видалення даних. Наприклад, вони можуть призвести до дублювання даних, що ускладнює їх оновлення та синхронізацію. Крім того, вони збільшують ризик втрати консистентності даних через неправильне оновлення або видалення.

--Частина 2: процес нормалізації

--1НФ
-- Розробіть структуру для переходу таблиці `Orders` до 1НФ, що передбачає унікальність записів та атомарність значень полів.
-- Створіть необхідні таблиці з унікальними первинними ключами.

CREATE TABLE Orders2 (
OrderID INT PRIMARY KEY,
CustomerID INT,
ProductID INT,
Quantity INT,
OrderDate DATE)
;

CREATE TABLE CustomerInfo (
CustomerID INT PRIMARY KEY,
CustomerName NVARCHAR(100)
);

CREATE TABLE ProductsINFO (
ProductID INT PRIMARY KEY,
ProductName NVARCHAR(100),
ProductCategory NVARCHAR(50),
UnitPrice DECIMAL(10,2)
);

--2НФ
-- Аналізуйте створені таблиці на предмет часткових залежностей. Розробіть структуру для усунення цих залежностей, розділяючи дані на додаткові таблиці.
-- Виконайте модифікацію структури бази даних для відповідності 2НФ, створіть необхідні таблиці та визначте зв'язки між ними.

CREATE TABLE Order_details (
OrderID INT,
ProductID INT,
Quantity INT,
PRIMARY KEY (OrderID, ProductID),
FOREIGN KEY (OrderID)
References Orders2(OrderID),
FOREIGN KEY (ProductID) 
REFERENCES ProductsINFO(ProductID)
);

--3НФ
-- Виявіть транзитивні залежності у ваших таблицях. Розробіть структуру таблиць, яка усуває транзитивні залежності.
-- Оновіть структуру бази даних, щоб відповідати вимогам 3НФ.

CREATE TABLE Orders3 (
OrderID INT PRIMARY KEY,
CustomerID INT,
OrderDate DATE,
FOREIGN KEY (CustomerID) REFERENCES CustomerINFO(CustomerID)
);

CREATE TABLE Products_INFO2 (
ProductID INT PRIMARY KEY,
ProductName NVARCHAR(100),
ProductCategory NVARCHAR(50),
UnitPrice DECIMAL(10,2)
);

CREATE TABLE Order_details2 (
OrderID INT,
ProductID INT,
Quantity INT,
PRIMARY KEY (OrderID, ProductID),
FOREIGN KEY (OrderID) References Orders3(OrderID),
FOREIGN KEY (ProductID) REFERENCES Products_INFO2 (ProductID)
);

SELECT*FROM Order_details2

--3 (реалізація та аналіз)

--Використовуючи T-SQL, створюємо оновлені таблиці відповідно до нашого проекту нормалізації
INSERT INTO [dbo].[CustomerInfo] (CustomerID, CustomerName)
VALUES
(1, 'Лідія'),
(2, 'Анастасія');

INSERT INTO [dbo].[Products_INFO2] (ProductID, ProductName, ProductCategory, UnitPrice)
VALUES
(1, 'Пральна машинка', 'Побутова техніка', 8000.00),
(2, 'Мікрохвильова піч', 'Побутова техніка', 2000.00);

INSERT INTO [dbo].[Orders3](OrderID, CustomerID, OrderDate)
VALUES
(1, 1, '2024.04.09'),
(2, 2, '2024.04.09');

INSERT INTO [dbo].[Order_details2] (OrderID, ProductID, Quantity)
VALUES
(1, 1, 1),
(2, 2, 1);

SELECT*FROM [dbo].[CustomerInfo];
SELECT*FROM [dbo].[Products_INFO2];
SELECT*FROM [dbo].[Orders3];
SELECT*FROM [dbo].[Order_details2]

--Тестування і аналіз:

--Вставка
INSERT INTO [dbo].[CustomerInfo] (CustomerID, CustomerName)
VALUES
(3, 'Лідія');

--Оновлення
UPDATE [dbo].[CustomerInfo]
SET CustomerName = 'Лідія'
WHERE CustomerID = 3;

--Видалення даних
DELETE FROM [dbo].[CustomerInfo]
WHERE CustomerID = 3;