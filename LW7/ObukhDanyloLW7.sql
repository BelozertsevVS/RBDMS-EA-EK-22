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
 (1, 'Mike', 'T-Shirt', 'Apparel', 2, 400.00, '20240315'),
 (2, 'James', 'Sweater', 'Knitwear', 1, 800.00, '20240316'),
 (3, 'Lucas', 'Jacket', 'Outerwear', 1, 1000.00, '20240317'),
 (4, 'Alexander','T-Shirt', 'Apparel', 1, 500.00, '20240318'),
 (5, 'Emma','Dress', 'Apparel', 3, 700.00, '20240319'),
 (6, 'Mike', 'Coat', 'Outerwear', 1, 700.00, '20240320'),
 (7, 'Matthew','Sweater', 'Knitwear', 2, 800.00, '20240321'),
 (8, 'Lucas',   'Jacket', 'Outerwear', 4, 2500.00, '20240322'),
 (9, 'James',   'Coat', 'Outerwear', 1, 1000.00, '20240323'),
 (10,'Emma', 'Dress', 'Apparel', 2, 1000.00, '20240324');

 SELECT * FROM [dbo].[Orders];

/*2. Аналіз проблем денормалізованої таблиці:
Аномалія вставки - повторення даних у полях можуть призвести до збільшення розміру бази даних та неодноразового введення одних і тих же даних.
Аномалія оновлення - при зміні даних, які пов'язані з денормалізованою таблицею, може знадобитися оновлення кількох записів.
Аномалія видалення - при видаленні запису можуть втратитися пов'язані дані.*/

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