-- Частина 1: Створення денормалізованої таблиці

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName NVARCHAR(100),
    ProductName NVARCHAR(100),
    ProductCategory NVARCHAR(50),
    Quantity INT,
    UnitPrice DECIMAL(10),
    OrderDate DATE
);

-- Внесення даних у таблицю
INSERT INTO [dbo].[Orders] (OrderID, CustomerName, ProductName, ProductCategory, Quantity, UnitPrice, OrderDate)
VALUES
(1, 'Іван', 'Ноутбук', 'Електроніка', 1, 25000, '2024-04-09'),
(2, 'Марія', 'Смартфон', 'Електроніка', 1, 15000, '2024-04-09'),
(3, 'Іван', 'Планшет', 'Електроніка', 1, 12000, '2024-04-08'),
(4, 'Петро', 'Ноутбук', 'Електроніка', 1, 27000, '2024-04-08'),
(5, 'Олена', 'Смарт-годинник', 'Електроніка', 2, 7000, '2024-04-08'),
(6, 'Андрій', 'Навушники', 'Аудіотехніка', 1, 2000, '2024-04-07'),
(7, 'Андрій', 'Колонка', 'Аудіотехніка', 2, 3000, '2024-04-06'),
(8, 'Василь', 'Смартфон', 'Електроніка', 1, 16000, '2024-04-05'),
(9, 'Тарас', 'Телевізор', 'Електроніка', 1, 30000, '2024-04-05'),
(10, 'Оксана', 'Смарт-годинник', 'Електроніка', 1, 6000, '2024-04-05');

SELECT * FROM [dbo].[Orders];

-- Денормалізовані таблиці можуть призводити до проблем з аномаліями вставки, оновлення та видалення даних. Наприклад, вони можуть призвести до дублювання даних, що ускладнює їх оновлення та синхронізацію. Крім того, вони збільшують ризик втрати консистентності даних через неправильне оновлення або видалення.

-- Частина 2: Процес нормалізації

-- 1НФ: Створення таблиць для унікальності записів та атомарності значень

CREATE TABLE Orders2 (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Quantity INT,
    OrderDate DATE
);

CREATE TABLE CustomerInfo (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(100)
);

CREATE TABLE ProductsInfo (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    ProductCategory NVARCHAR(50),
    UnitPrice DECIMAL(10, 2)
);

-- 2НФ: Аналіз та усунення часткових залежностей

CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders2(OrderID),
    FOREIGN KEY (ProductID) REFERENCES ProductsInfo(ProductID)
);

-- 3НФ: Усунення транзитивних залежностей

CREATE TABLE Orders3 (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES CustomerInfo(CustomerID)
);

CREATE TABLE ProductsInfo2 (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    ProductCategory NVARCHAR(50),
    UnitPrice DECIMAL(10, 2)
);

CREATE TABLE OrderDetails2 (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders3(OrderID),
    FOREIGN KEY (ProductID) REFERENCES ProductsInfo2(ProductID)
);

SELECT * FROM OrderDetails2;

-- Вставка даних в оновлені таблиці

INSERT INTO CustomerInfo (CustomerID, CustomerName)
VALUES
(1, 'Людмила'),
(2, 'Степан');

INSERT INTO ProductsInfo2 (ProductID, ProductName, ProductCategory, UnitPrice)
VALUES
(1, 'Ноутбук', 'Електроніка', 18000.00),
(2, 'Смарт-годинник', 'Електроніка', 21000.00);

INSERT INTO Orders3 (OrderID, CustomerID, OrderDate)
VALUES
(1, 1, '2024-04-10'),
(2, 2, '2024-04-10');
INSERT INTO OrderDetails2 (OrderID, ProductID, Quantity)
VALUES
(1, 1, 1),
(2, 2, 1);
SELECT * FROM CustomerInfo;
SELECT * FROM ProductsInfo2;
SELECT * FROM Orders3;
SELECT * FROM OrderDetails2;

-- Тестування і аналіз

-- Вставка
INSERT INTO CustomerInfo (CustomerID, CustomerName)
VALUES
(10, 'Ірина');

-- Оновлення
UPDATE CustomerInfo
SET CustomerName = 'Ірина Петрівна'
WHERE CustomerID = 10;

-- Видалення даних
DELETE FROM CustomerInfo
WHERE CustomerID = 10;

-- Заключні вибірки для перевірки структури
SELECT * FROM CustomerInfo;
SELECT * FROM ProductsInfo2;
SELECT * FROM Orders3;
SELECT * FROM OrderDetails2;

