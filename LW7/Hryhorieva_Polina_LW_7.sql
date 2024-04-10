--Створення бази даних 
CREATE DATABASE ORDERS;
USE ORDERS;
--Створення таблиці Orders
CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  CustomerName VARCHAR(50),
  ProductName VARCHAR(50),
  ProductCategory INT,
  Quantity INT,
  UnitPrice MONEY,
  OrderDate DATETIME
 );
 --Заповнення таблиці Orders. Перехід до 1НФ
 INSERT INTO Orders (OrderID, CustomerName, ProductName, ProductCategory, Quantity, UnitPrice, OrderDate)
   VALUES 
   (1, 'Джейн', 'Ківі', '1', 12, 13.00, '2024-01-02 12:00:00'),
   (2, 'Олівер', 'Полуниця', '2', 17, 19.00, '2024-01-03 11:00:00'),
   (3, 'Клара', 'Помідори', '3', 10, 20.00, '2024-01-04 19:00:00'),
   (4, 'Олівія', 'Хліб', '4', 9, 11.00, '2024-01-05 13:00:00'),
   (5, 'Том', 'Сметана', '5', 23, 15.00, '2024-01-06 20:00:00'),
   (6, 'Марко', 'Тістечка', '6', 11, 8.00, '2024-01-07 14:00:00'),
   (7, 'Пенелора', 'Морозиво', '7', 99, 27.00, '2024-01-08 15:00:00'),
   (8, 'Кайлі', 'Цукерки', '8', 15, 7.00, '2024-01-09 22:00:00'),
   (9, 'Девід', 'Шоколад', '9', 6, 9.00, '2024-01-10 09:00:00'),
   (10, 'Карл', 'Яблука', '10', 44, 50.00, '2024-01-11 09:30:00');
--Перевірка даних
   SELECT*FROM Orders;
--Перехід до 2НФ та 3НФ
--Створення таблиці Transportation
CREATE TABLE Transportation (
  OrderID INT PRIMARY KEY,
  CarrierID INT,
  OrderDate DATETIME
  );
--Додавання FOREIGN KEY
ALTER TABLE Transportation ADD CONSTRAINT FK_Transportation_OrderID FOREIGN KEY (OrderID) REFERENCES Orders (OrderID);
--Заповнення таблиці Transportation
INSERT INTO Transportation (OrderID, CarrierID, OrderDate)
  VALUES 
  (1, 2, '2024-01-02 12:00:00'),
  (2, 3, '2024-01-03 11:00:00'),
  (3, 4, '2024-01-04 19:00:00'),
  (4, 5, '2024-01-05 13:00:00'),
  (5, 6, '2024-01-06 20:00:00'),
  (6, 7, '2024-01-07 14:00:00'),
  (7, 8, '2024-01-08 15:00:00'),
  (8, 9, '2024-01-09 22:00:00'),
  (9, 10, '2024-01-10 09:00:00'),
  (10, 11, '2024-01-11 09:30:00');
--Перевірка даних
 SELECT * FROM Transportation;
 --Створення таблиці Storage
 CREATE TABLE Storage (
   OrderID INT PRIMARY KEY,
   StorageID INT,
   OrderDate DATETIME
   );
--Додавання FOREIGN KEY
ALTER TABLE Storage ADD CONSTRAINT FK_Storage_OrderID FOREIGN KEY (OrderID) REFERENCES Orders (OrderID);
--Заповнення таблиці Storage
INSERT INTO Storage (OrderID, StorageID, OrderDate)
VALUES 
  (1, 17, '2024-01-02 12:00:00'),
  (2, 20, '2024-01-03 11:00:00'),
  (3, 9, '2024-01-04 19:00:00'),
  (4, 15, '2024-01-05 13:00:00'),
  (5, 11, '2024-01-06 20:00:00'),
  (6, 1, '2024-01-07 14:00:00'),
  (7, 12, '2024-01-08 15:00:00'),
  (8, 33, '2024-01-09 22:00:00'),
  (9, 25, '2024-01-10 09:00:00'),
  (10, 50, '2024-01-11 09:30:00');
--Перевірка даних
 SELECT * FROM Storage;
--Видалення таблиці Transportation
DROP TABLE Transportation;
--Видалення таблиці Storage
DROP TABLE Storage;
