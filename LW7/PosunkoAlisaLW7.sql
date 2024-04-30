/*
Частина 1: аналіз існуючої структури
1. Створення денормалізованої таблиці:
- Створіть денормалізовану таблицю `Orders`, яка містить поля: `OrderID`, `CustomerName`, `ProductName`, `ProductCategory`, `Quantity`, `UnitPrice`, `OrderDate`.
- Додайте в таблицю довільні записи (мінімум 10), які містять повторювані значення в полях `CustomerName`, `ProductName`, і `ProductCategory`.
*/

CREATE DATABASE test1
USE test1

CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
CustomerName NVARCHAR(50),
ProductName NVARCHAR(50),
ProductCategory NVARCHAR(50),
Quantity INT,
UnitPrice DECIMAL(10, 2),
OrderDate DATE
);

INSERT INTO Orders (OrderID, CustomerName, ProductName, ProductCategory, Quantity, UnitPrice, OrderDate) VALUES
(1, 'customer1', 'product 1', 'category1', 1, 100.00, '2024-03-21'),
(2, 'customer2', 'product 2', 'category2', 2, 200.00, '2024-03-20'),
(3, 'customer3', 'product 3', 'category3', 3, 300.00, '2024-03-02'),
(4, 'customer4', 'product 1', 'category1', 1, 100.00, '2024-03-08'),
(5, 'customer1', 'product 1', 'category1', 5, 500.00, '2024-01-22'),
(6, 'customer6', 'product 6', 'category6', 6, 600.00, '2024-02-22'),
(7, 'customer7', 'product 7', 'category7', 1, 100.00, '2023-03-22'),
(8, 'customer8', 'product 8', 'category8', 8, 800.00, '2024-03-19'),
(9, 'customer1', 'product 1', 'category1', 1, 100.00, '2024-03-01'),
(10, 'customer10', 'product 1', 'category1', 18, 1800.00, '2024-03-13');

/* 2. Аналіз проблем денормалізованої таблиці:
- Опишіть потенційні проблеми денормалізованої таблиці, такі як аномалії вставки, оновлення, видалення.
Аномалії вставки: неможливе додання нового типу продукції чи каталогу без створення замовлення
Аномалії оновлення: зміна назви продукту привете до необхідності оновлення всіх замовлень з цим продуктом
Аномалії видалення: якщо продукт був тільки в одному замовлені та це замовлення видалять, цей продукт втратиться
*/

/* Частина 2: процес нормалізації
3.  Перехід до 1НФ (Перша нормальна форма):
- Розробіть структуру для переходу таблиці `Orders` до 1НФ, що передбачає унікальність записів та атомарність значень полів.
- Створіть необхідні таблиці з унікальними первинними ключами.
*/

CREATE TABLE Customers1 (
CustomerID INT PRIMARY KEY,
CustomerName NVARCHAR(50)
);

CREATE TABLE Products1 (
ProductID INT PRIMARY KEY,
ProductName NVARCHAR(50),
ProductCategory NVARCHAR(50)
);

/* 4. Перехід до 2НФ (Друга нормальна форма):
- Аналізуйте створені таблиці на предмет часткових залежностей. Розробіть структуру для усунення цих залежностей, розділяючи дані на додаткові таблиці.
- Виконайте модифікацію структури бази даних для відповідності 2НФ, створіть необхідні таблиці та визначте зв'язки між ними.
*/

CREATE TABLE Orders1 (
OrderID INT PRIMARY KEY,
CustomerID INT,
ProductID INT,
Quantity INT,
UnitPrice DECIMAL(10, 2),
OrderDate DATE,
FOREIGN KEY (CustomerID) REFERENCES Customers1(CustomerID),
FOREIGN KEY (ProductID) REFERENCES Products1(ProductID)
);

/* 5. Перехід до 3НФ (Третя нормальна форма):
- Виявіть транзитивні залежності у ваших таблицях. Розробіть структуру таблиць, яка усуває транзитивні залежності.
- Оновіть структуру бази даних, щоб відповідати вимогам 3НФ.
*/

CREATE TABLE Orders2 (
OrderID INT PRIMARY KEY,
CustomerID INT,
ProductID INT,
Quantity INT,
FOREIGN KEY (CustomerID) REFERENCES Customers1(CustomerID),
FOREIGN KEY (ProductID) REFERENCES Products1(ProductID)
);

CREATE TABLE OrderNew (
OrderID INT PRIMARY KEY,
UnitPrice DECIMAL(10, 2),
OrderDate DATE,
FOREIGN KEY (OrderID) REFERENCES Orders2(OrderID)
);

/* Частина 3: реалізація та аналіз
6. Створення нормалізованої бази даних:
- Використовуючи T-SQL, створіть оновлені таблиці відповідно до вашого проекту нормалізації.
- Заповніть таблиці даними, відображаючи зв'язки між ними.
*/

INSERT INTO Customers1 (CustomerID, CustomerName)
VALUES
(1, 'customer1'),
(2, 'customer2'),
(3, 'customer3'),
(4, 'customer4'),
(5, 'customer6'),
(6, 'customer7'),
(7, 'customer10'),
(8, 'customer8');

INSERT INTO Products1 (ProductID, ProductName, ProductCategory)
VALUES
(1, 'product 1', 'category1'),
(2, 'product 2', 'category2'),
(3, 'product 3', 'category3'),
(4, 'product 6', 'category6'),
(5, 'product 7', 'category7'),
(6, 'product 8', 'category8');

INSERT INTO Orders2 (OrderID, CustomerID, ProductID, Quantity)
VALUES
(1, 1, 1, 1),
(2, 2, 2, 1),
(3, 3, 3, 2),
(4, 1, 1, 7),
(5, 4, 4, 1),
(6, 8, 6, 4),
(7, 5, 1, 13),
(8, 6, 3, 6),
(9, 3, 4, 2),
(10, 1, 2, 8);

INSERT INTO OrderNew (OrderID, UnitPrice, OrderDate)
VALUES
(1, 100.00, '2024-03-21'),
(2, 200.00, '2024-03-20'),
(3, 300.00, '2024-03-02'),
(4, 100.00, '2024-03-08'),
(5, 500.00, '2024-01-22'),
(6, 600.00, '2024-02-22'),
(7, 100.00, '2023-03-22'),
(8, 800.00, '2024-03-19'),
(9, 100.00, '2024-03-01'),
(10, 1800.00, '2024-03-13');

-- Перевірка
SELECT * FROM [dbo].[Customers1];
SELECT * FROM [dbo].[Products1];
SELECT * FROM [dbo].[Orders2];
SELECT * FROM [dbo].[OrderNew];

/* 7. Тестування і аналіз:
- Виконайте запити для вставки, оновлення, та видалення даних в нормалізованій структурі. 
Продемонструйте, як нормалізація вирішує проблеми аномалій даних.
- Проаналізуйте ефективність вашої нормалізованої структури у порівнянні з денормалізованою таблицею:

Нормалізована структура бази даних дозволяє уникнути дублювання даних та мінімізує ризик аномалій даних, 
але менш швидка у виконанні деяких запитів через багаторівневі зв'язки та об'єднаннях таблиць, 
тому денормалізована таблиця може бути швидшою для простих запитів, але вона менш безпечна для цілісності даних.
*/

-- Вставка нового замовлення 
INSERT INTO Orders2 (OrderID, CustomerID, ProductID, Quantity)
VALUES
(11, 4, 1, 10);

-- Додавання інформації про замовлення
INSERT INTO OrderNew (OrderID, UnitPrice, OrderDate)
VALUES
(11, 190, '2024-04-20');

-- Оновлення кількості товару в існуючому замовленні
UPDATE Orders2
SET Quantity = 12
WHERE OrderID = 10;

-- Оновлення ціни одиниці товару в існуючому замовленні
UPDATE OrderNew
SET UnitPrice = 12000
WHERE OrderID = 10;

-- Видалення замовлення та інформації про нього
DELETE FROM OrderNew
WHERE OrderID = 9;
DELETE FROM Orders2
WHERE OrderID = 9;


