-- Частина 1: аналіз існуючої структури

-- Створюєму базу даних "База магазину"
CREATE DATABASE StoreBase;

USE StoreBase;

-- Створюємо денормалізовану таблицю `Orders`
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    ProductName VARCHAR(100),
    ProductCategory VARCHAR(50),
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    OrderDate DATE
);

-- До створеною таблиці дадаєм 10 довільних записів, які містять повторювані значення в полях `CustomerName`, `ProductName`, і `ProductCategory
INSERT INTO Orders (OrderID, CustomerName, ProductName, ProductCategory, Quantity, UnitPrice, OrderDate) VALUES
(1, 'Люда Мащюк', 'Laptop', 'Electronics', 2, 1200.00, '2024-03-01'),
(2, 'Ігор Тремболець', 'Mobile Phone', 'Electronics', 1, 800.00, '2024-03-02'),
(3, 'Люда Мащюк', 'Desk Chair', 'Furniture', 4, 150.00, '2024-03-03'),
(4, 'Петро Іванов', 'Sofa', 'Furniture', 1, 1200.00, '2024-03-04'),
(5, 'Ігор Тремболець', 'Tablet', 'Electronics', 3, 500.00, '2024-03-05'),
(6, 'Люда Мащюк', 'Chair', 'Furniture', 2, 100.00, '2024-03-06'),
(7, 'Аліса Батьківна', 'Bookshelf', 'Furniture', 1, 200.00, '2024-03-07'),
(8, 'Петро Іванов', 'Television', 'Electronics', 1, 1500.00, '2024-03-08'),
(9, 'Аліса Батьківна', 'Laptop', 'Electronics', 1, 1100.00, '2024-03-09'),
(10, 'Ігор Тремболець', 'Chair', 'Furniture', 1, 100.00, '2024-03-10');

SELECT * FROM Orders;

--Потенційні проблеми денормалізованої таблиці включають:
-- 1) Аномалія вставки: Неможливість додати нове значення без дублювання деяких даних (наприклад, ім'я клієнта або назва товару).
-- 2) Аномалія оновлення: Якщо покупець змінює своє ім'я, його доведеться оновлювати в кожному замовленні.
-- 3) Аномалія видалення: Видалення замовлення може призвести до видалення інформації про покупця або товар, яка може бути важливою для інших замовлень.

-- Частина 2: процес нормалізації

-- Перехід до 1НФ
-- 1НФ передбачає унікальність записів та атомарність значень полів.
-- Так як в попередній таблиці Orders є первинний ключ, то всі записи є автоматично унікальними.
--Для уникнинення атомарності значень полів, ми маємо розділити дубльовані дані у полях CustomerName, ProductName, і ProductCategory у відповідні окремі таблиці.

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) UNIQUE
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) UNIQUE,
    ProductCategory VARCHAR(50),
	UnitPrice DECIMAL(10, 2),
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
	CustomerID INT,
	ProductID INT,
    Quantity INT,
    OrderDate DATE
);
 


--Перехід до 2НФ:

--Друга нормальна форма (2НФ) вимагає видалення часткових залежностей від первинного ключа. 
--Це означає, що кожне неключове поле повинно повністю залежати від всіх ключів таблиці, а не тільки від певної їх частини.
--Аналіз таблиць на предмет часткових залежностей:

SELECT * FROM Products;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- При аналізі структури бази даних ми виявили, що таблиця Orders містить часткові залежності, оскільки Quantity та OrderDate залежать лише від OrderID, а не від усього первинного ключа. Тому нам потрібно розділити цю таблицю для вирішення цих проблем.
-- Відповідно до цього, ми вирішимо перейти до такої структури:
-- Orders таблиця буде містити лише поля OrderID, CustomerID, та OrderDate, оскільки це є атрибути, які унікально ідентифікують замовлення.
-- Ми створимо нову таблицю OrderDetails, де будуть зберігатися деталі про товари, що містяться у замовленні. Ця таблиця міститиме поля OrderID, ProductID, Quantity.
-- Products таблиця буде містити лише поля ProductID, ProductName, ProductCategory, UnitPrice, які не мають часткових функціональних залежностей.
-- І потрібно у цих таблицях використати зовнішні ключі, щоб забезпечити зв'язок між ними.Для цього видалемо таблицю попердні таблиці  і створимо спочатку, із зовнішними ключами.
 

DROP TABLE Orders;
DROP TABLE Customers;
DROP TABLE Products;

-- Таблиця покупців
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) UNIQUE
);

-- Таблиця продуктів
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) UNIQUE,
    ProductCategory VARCHAR(50),
	UnitPrice DECIMAL(10, 2)
);

-- Таблиця замовлень
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
	CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Таблиця деталей замовлення
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

SELECT * FROM Products;
SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;


-- Перехід до 3НФ:
);-- Третя нормальна форма (3НФ) вимагає усунення транзитивних залежностей від первинного ключа.
-- Це означає, що кожне неключове поле повинно залежати тільки від первинного ключа, а не від інших неключових полів.

-- Після перевірки, не було виявлено транзитичних залежностей. тому можна вважати наступну структу БД номмалізованою до 3НФ.

-- Тепер видаляемо попередньо створену БД і виконуємо вже нормалізовану структуру

DROP DATABASE StoreBase;

CREATE DATABASE StoreBase;

USE StoreBase;

-- Таблиця покупців
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) UNIQUE
);

-- Таблиця продуктів
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) UNIQUE,
    ProductCategory VARCHAR(50),
	UnitPrice DECIMAL(10, 2)
);

-- Таблиця замовлень
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
	CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Таблиця деталей замовлення
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

SELECT * FROM Products;
SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;

-- Вставка даних в таблицю Customers
INSERT INTO Customers (CustomerID, CustomerName) VALUES
(1, 'Люда Мащюк'),
(2, 'Ігор Тремболець'),
(3, 'Петро Іванов'),
(4, 'Аліса Батьківна');

-- Вставка даних в таблицю Products
INSERT INTO Products (ProductID, ProductName, ProductCategory, UnitPrice) VALUES
(1, 'Laptop', 'Electronics', 1200.00),
(2, 'Mobile Phone', 'Electronics', 800.00),
(3, 'Desk Chair', 'Furniture', 150.00),
(4, 'Sofa', 'Furniture', 1200.00),
(5, 'Tablet', 'Electronics', 500.00),
(6, 'Chair', 'Furniture', 100.00),
(7, 'Bookshelf', 'Furniture', 200.00),
(8, 'Television', 'Electronics', 1500.00);

-- Вставка даних в таблицю Orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(1, 1, '2024-03-01'),
(2, 2, '2024-03-02'),
(3, 1, '2024-03-03'),
(4, 3, '2024-03-04'),
(5, 2, '2024-03-05'),
(6, 1, '2024-03-06'),
(7, 4, '2024-03-07'),
(8, 3, '2024-03-08'),
(9, 4, '2024-03-09'),
(10, 2, '2024-03-10');

-- Вставка даних в таблицю OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES
(1, 1, 2),
(2, 2, 1),
(3, 3, 4),
(4, 4, 1),
(5, 5, 3),
(6, 6, 2),
(7, 7, 1),
(8, 8, 1),
(9, 1, 1),
(10, 6, 1);

SELECT * FROM Products;
SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;

Тестування і аналіз:

-- Виконання запитів для вставки, оновлення та видалення даних:

-- Вставка нового замовлення
INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES (11, 3, '2024-03-11');

-- Оновлення імені покупця
UPDATE Customers SET CustomerName = 'Олег Кузьменко' WHERE CustomerID = 3;

-- Видалення замовлення
DELETE FROM Orders WHERE OrderID = 11;

-- Аналіз ефективності нормалізованої структури у порівнянні з денормалізованою таблицею:

-- Нормалізована структура бази даних дозволяє уникнути аномалій вставки, оновлення та видалення, які можуть виникнути в денормалізованій структурі. Завдяки розділенню даних на окремі таблиці і використанню зовнішніх ключів, ми забезпечуємо цілісність даних та ефективне управління ними.
-- Наприклад, якщо покупець змінить своє ім'я, цю зміну буде потрібно зробити лише в таблиці Customers, і вона автоматично оновиться в усіх пов'язаних замовленнях. Також, видалення або оновлення товару не призведе до втрати інформації про замовлення.
-- Нормалізована структура забезпечує кращу організацію даних і полегшує проведення різних операцій з ними. Вона підвищує ефективність обробки даних і робить систему більш масштабованою та підтримуваною.






