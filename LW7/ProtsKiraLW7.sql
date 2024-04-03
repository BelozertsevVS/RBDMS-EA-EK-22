/* ЗАВДАННЯ
Частина 1: аналіз існуючої структури
1. Створення денормалізованої таблиці:
- Створіть денормалізовану таблицю `Orders`, яка містить поля: `OrderID`, `CustomerName`, `ProductName`, `ProductCategory`, `Quantity`, `UnitPrice`, `OrderDate`.
- Додайте в таблицю довільні записи (мінімум 10), які містять повторювані значення в полях `CustomerName`, `ProductName`, і `ProductCategory`.*/ 
CREATE DATABASE TestShop;

USE TestShop;

CREATE TABLE Orders (
    OrderID         INT PRIMARY KEY,
    CustomerName    NVARCHAR(100),
    ProductName     NVARCHAR(100),
    ProductCategory NVARCHAR(50),
    Quantity        INT,
    UnitPrice       DECIMAL(10,2),
    OrderDate       DATE
);

INSERT INTO [dbo].[Orders](OrderID, CustomerName, ProductName, ProductCategory, Quantity, UnitPrice, OrderDate)
VALUES 
 (1, 'Євгенія', 'Ноутбук', 'Електроніка', 2, 1200.00, '20240315'),
 (2, 'Микола', 'Смартфон', 'Електроніка', 1, 800.00, '20240316'),
 (3, 'Євгенія', 'Планшет', 'Електроніка', 1, 500.00, '20240317'),
 (4, 'Микола',       'ПК', 'Електроніка', 1, 5000.00, '20240318'),
 (5, 'Олексій','Смартфон', 'Електроніка', 3, 2400.00, '20240319'),
 (6, 'Олексій',      'ПК', 'Електроніка', 1, 4999.99, '20240320'),
 (7, 'Наталія','Навушники',    'Гаджети', 2, 300.00, '20240321'),
 (8, 'Ніна',   'Планшет',  'Електроніка', 4, 2500.00, '20240322'),
 (9, 'Ніна',   'См.годинник', 'Гаджети', 1, 1000.00, '20240323'),
 (10,'Євгенія', 'Планшет', 'Електроніка', 2, 1000.00, '20240324');

 SELECT * FROM [dbo].[Orders];

/*2. Аналіз проблем денормалізованої таблиці:

Аномалія вставки: повторення даних у полях можуть призвести до збільшення розміру бази даних та неодноразового введення одних і тих же даних.

Аномалія оновлення: при зміні даних, які пов'язані з денормалізованою таблицею, може знадобитися оновлення кількох записів.

Аномалія видалення: при видаленні запису можуть втратитися пов'язані дані.*/

/*Частина 2: процес нормалізації
3. Перехід до 1НФ (Перша нормальна форма):
- Розробіть структуру для переходу таблиці `Orders` до 1НФ, що передбачає унікальність записів та атомарність значень полів.
- Створіть необхідні таблиці з унікальними первинними ключами.
4. Перехід до 2НФ (Друга нормальна форма):
- Аналізуйте створені таблиці на предмет часткових залежностей. Розробіть структуру для усунення цих залежностей, розділяючи дані на додаткові таблиці.
- Виконайте модифікацію структури бази даних для відповідності 2НФ, створіть необхідні таблиці та визначте зв'язки між ними.
5. Перехід до 3НФ (Третя нормальна форма):
- Виявіть транзитивні залежності у ваших таблицях. Розробіть структуру таблиць, яка усуває транзитивні залежності.
- Оновіть структуру бази даних, щоб відповідати вимогам 3НФ.
*/
-- 1 НФ:
CREATE TABLE Orders_2(
    OrderID    INT PRIMARY KEY,
    CustomerID INT,
    ProductID  INT,
    Quantity   INT,
    OrderDate  DATE
);

CREATE TABLE CustomersINFO (
    CustomerID   INT PRIMARY KEY,
    CustomerName NVARCHAR(100)
);

CREATE TABLE ProductsINFO (
    ProductID       INT PRIMARY KEY,
    ProductName     NVARCHAR(100),
    ProductCategory NVARCHAR(50),
    UnitPrice       DECIMAL(10,2)
);

--2 НФ:
CREATE TABLE Order_Details (
    OrderID   INT,
    ProductID INT,
    Quantity  INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID)   REFERENCES Orders_2(OrderID),
    FOREIGN KEY (ProductID) REFERENCES ProductsINFO(ProductID)
);

-- 3 НФ:
CREATE TABLE Orders_3 (
    OrderID    INT PRIMARY KEY,
    CustomerID INT,
    OrderDate  DATE,
    FOREIGN KEY (CustomerID) REFERENCES CustomersINFO(CustomerID)
);

CREATE TABLE Order_Details2 (
    OrderID   INT,
    ProductID INT,
    Quantity  INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID)   REFERENCES Orders_3(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products_INFO2(ProductID)
);

CREATE TABLE Products_INFO2 (
    ProductID       INT PRIMARY KEY,
    ProductName     NVARCHAR(100),
    ProductCategory NVARCHAR(50),
    UnitPrice       DECIMAL(10,2)
);

/*6. Створення нормалізованої бази даних:
- Використовуючи T-SQL, створіть оновлені таблиці відповідно до вашого проекту нормалізації.
- Заповніть таблиці даними, відображаючи зв'язки між ними.
*/

INSERT INTO [dbo].[CustomersINFO](CustomerID, CustomerName)
VALUES
(1, 'Євгенія'),
(2, 'Микола');

INSERT INTO [dbo].[Products_INFO2] (ProductID, ProductName, ProductCategory, UnitPrice) 
VALUES
 (1, 'Ноутбук', 'Електроніка', 1200.00),
 (2, 'Смартфон','Електроніка', 800.00);

INSERT INTO [dbo].[Orders_3] (OrderID, CustomerID, OrderDate) 
VALUES
(1, 1, '20240315'),
(2, 2, '20240316');

INSERT INTO [dbo].[Order_Details2] (OrderID, ProductID, Quantity) 
VALUES
(1, 1, 2),
(2, 2, 1);

SELECT * FROM [dbo].[CustomersINFO];
SELECT * FROM [dbo].[Products_INFO2];
SELECT * FROM [dbo].[Orders_3];
SELECT * FROM [dbo].[Order_Details2];

/*7. Тестування і аналіз:
- Виконайте запити для вставки, оновлення, та видалення даних в нормалізованій структурі. Продемонструйте, як нормалізація вирішує проблеми аномалій даних.
- Проаналізуйте ефективність вашої нормалізованої структури у порівнянні з денормалізованою таблицею.
*/

-- Тест на вставку
INSERT INTO [dbo].[CustomersINFO] (CustomerID, CustomerName) 
VALUES 
(3, 'Олег');

-- Тест на оновлення
UPDATE [dbo].[CustomersINFO] 
SET    CustomerName = 'Олег' 
WHERE  CustomerID = 3;

-- Тест на видалення
DELETE FROM [dbo].[CustomersINFO]  
WHERE       CustomerID = 3;

/*Отже, нормалізована структура бази даних дозволяє покращити ефективність зберігання, забезпечити цілісність та уникнути аномалії даних,
зробити базу даних більш масштабованою та легкою для управління*/