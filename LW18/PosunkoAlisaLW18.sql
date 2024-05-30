/*Завдання 1 
Створіть користувацьку скалярну функцію, яка приймає ідентифікатор клієнта як 
вхідний параметр і повертає ідентифікатор найновішого замовлення клієнта.*/

CREATE FUNCTION LatestOrderID
(@cust_num INT) -- Параметр, що вказує ідентифікатор клієнта
RETURNS INT -- Повертає останній номер замовлення
AS
BEGIN
DECLARE @latest_order_id INT; -- Змінна для зберігання останнього номера замовлення
SELECT @latest_order_id = MAX(ORDER_NUM) -- Вибірка максимального номера замовлення для вказаного клієнта
FROM ORDERS
WHERE CUST = @cust_num; -- Обмеження вибірки ідентифікатором клієнта
RETURN @latest_order_id; -- Повернення останнього номера замовлення
END;

--Перевірка

DECLARE @customer_id INT;
SET @customer_id = 2117; 
SELECT dbo.LatestOrderID(@customer_id) AS LatestOrderID;

SELECT *
FROM [dbo].[ORDERS]


/* Завдання 2
Створіть користувацьку inline функцію, яка приймає на вхід параметри: дата початку періоду та дата кінця періоду. 
Функція повертає дані продукту з найбільшою середньою кількістю проданих одиниць товару за період. */

CREATE FUNCTION ProductWithMaxAvgSales
(@start_date DATETIME, -- Параметр, що вказує на початкову дату періоду
 @end_date DATETIME) -- Параметр, що вказує на кінцеву дату періоду
RETURNS TABLE -- Функція повертає таблицю
AS
RETURN
(
SELECT TOP 1 [PRODUCT], AVG(QTY) AS AvgSales -- Вибірка першого рядка з найбільшим середнім продажем
FROM ORDERS
WHERE ORDER_DATE BETWEEN @start_date AND @end_date -- Обмеження вибірки датою замовлення, що знаходиться між початковою та кінцевою датами
GROUP BY [PRODUCT] -- Групування за назвою продукту
ORDER BY AVG(QTY) DESC -- Сортування за спаданням середнього продажу
);

--Перевірка

DECLARE @start_date DATETIME;
DECLARE @end_date DATETIME;
SET @start_date = '2007-12-17'; 
SET @end_date = '2008-01-11'; 
SELECT *
FROM dbo.ProductWithMaxAvgSales(@start_date, @end_date);

SELECT *
FROM [dbo].[ORDERS]

/* Завдання 3
Створіть користувацьку Multi-statement функцію, яка приймає на вхід параметри: дата початку періоду та дата кінця періоду. 
Функція повертає дані продукту з найбільшою середньою кількістю проданих одиниць товару, 
з найбільшою середньою сумою продажів і з найбільшою кількістю проведених замовлень за період.*/

CREATE FUNCTION TopProductStatistics
(@start_date DATETIME,
 @end_date DATETIME) 
RETURNS @TopProducts TABLE -- Функція повертає таблицю
(
ProductID CHAR(5), -- Стовпець для ідентифікатора продукту
AvgQtySold DECIMAL(10, 2), -- Стовпець для середньої кількості проданих одиниць товару
AvgSalesAmount MONEY, -- Стовпець для середньої суми продажів
TotalOrders INTEGER -- Стовпець для загальної кількості проведених замовлень
)
AS
BEGIN
-- Дані з найбільшою середньою кількістю проданих одиниць товару
INSERT INTO @TopProducts (ProductID, AvgQtySold)
SELECT TOP 1 WITH TIES PRODUCT, AVG(QTY) AS AvgQty
FROM ORDERS
WHERE ORDER_DATE BETWEEN @start_date AND @end_date
GROUP BY PRODUCT
ORDER BY AvgQty DESC;

-- Дані з найбільшою середньою сумою продажів
UPDATE @TopProducts
SET AvgSalesAmount = (
SELECT TOP 1 WITH TIES SUM(AMOUNT) AS AvgSales
FROM ORDERS
WHERE PRODUCT = ProductID
GROUP BY PRODUCT
ORDER BY AvgSales DESC
);

-- Дані з найбільшою кількістю проведених замовлень
UPDATE @TopProducts
SET TotalOrders = (
SELECT TOP 1 WITH TIES COUNT(*) AS TotalOrders
FROM ORDERS
WHERE PRODUCT = ProductID
GROUP BY PRODUCT
ORDER BY TotalOrders DESC
);

RETURN;
END;

--Перевірка
DECLARE @start_date DATETIME;
DECLARE @end_date DATETIME;
SET @start_date = '2007-12-17'; 
SET @end_date = '2008-01-11'; 
SELECT * FROM dbo.TopProductStatistics(@start_date, @end_date);

--Видалення
DROP FUNCTION IF EXISTS LatestOrderID;
DROP FUNCTION IF EXISTS ProductWithMaxAvgSales;
DROP FUNCTION IF EXISTS TopProductStatistics;
