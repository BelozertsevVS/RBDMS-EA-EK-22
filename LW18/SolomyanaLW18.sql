USE WebStor;

/*Завдання 1
Створіть користувацьку скалярну функцію, яка приймає ідентифікатор клієнта як вхідний параметр і повертає ідентифікатор найновішого замовлення клієнта.
*/
CREATE FUNCTION LatestOrder (@CustomerID INT) 
RETURNS INT 
AS 
BEGIN 
    DECLARE @LatestOrderID INT; 

    SELECT @LatestOrderID = [ORDER_NUM] 
    FROM [dbo].[ORDERS] 
    WHERE [CUST] = @CustomerID 
    ORDER BY [ORDER_DATE] DESC; 

    RETURN @LatestOrderID; 
END;

-- Перевіримо функцію 

DECLARE @CustomerID INT = 2103; -- Призначте значення ідентифікатора клієнта, для якого знайти найновіше замовлення

SELECT dbo.LatestOrder(@CustomerID) AS LatestOrderID;

SELECT * FROM [dbo].[ORDERS];


/*Завдання 2
Створіть користувацьку inline функцію, яка приймає на вхід параметри: 
дата початку періоду та дата кінця періоду. 
Функція повертає дані продукту з найбільшою середньою кількістю проданих одиниць товару за період.
*/

CREATE FUNCTION ProductWithMaxAvgSales (@StartDate DATE, @EndDate DATE)
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 1 [PRODUCT], AVG([QTY]) AS AvgSales
    FROM [dbo].[ORDERS]
    WHERE [ORDER_DATE] BETWEEN @StartDate AND @EndDate
    GROUP BY [PRODUCT]
    ORDER BY AVG([QTY]) DESC
);

-- Перевіримо функцію

DECLARE @StartDate DATE = '2007-01-01'; -- Початкова дата періоду
DECLARE @EndDate DATE = '2007-12-31'; -- Кінцева дата періоду

SELECT * FROM dbo.ProductWithMaxAvgSales(@StartDate, @EndDate);

SELECT * FROM [dbo].[ORDERS];


/*Завдання 3
Створіть користувацьку Multi-statement функцію, яка приймає на вхід параметри: 
дата початку періоду та дата кінця періоду. 
Функція повертає дані продукту з найбільшою середньою кількістю проданих одиниць товару, з найбільшою середньою сумою продажів і з найбільшою кількістю проведених замовлень за період.
*/

CREATE FUNCTION TopProductStats (@StartDate DATE, @EndDate DATE)
RETURNS @ProductStats TABLE
(
    [PRODUCT] CHAR(5),
    AvgQuantity DECIMAL(10,2),
    AvgSales DECIMAL(10,2),
    OrderCount INT
)
AS
BEGIN
    INSERT INTO @ProductStats ([PRODUCT], AvgQuantity, AvgSales, OrderCount)
    SELECT TOP 1 [PRODUCT], AVG([QTY]) AS AvgQuantity, AVG([AMOUNT]) AS AvgSales, COUNT(*) AS OrderCount
    FROM [dbo].[ORDERS]
    WHERE [ORDER_DATE] BETWEEN @StartDate AND @EndDate
    GROUP BY [PRODUCT]
    ORDER BY AvgQuantity DESC, AvgSales DESC, OrderCount DESC;

    RETURN;
END;

-- Перевіремо функцію

DECLARE @StartDate DATE = '2007-01-01'; -- Початкова дата періоду
DECLARE @EndDate DATE = '2007-12-31'; -- Кінцева дата періоду

SELECT * FROM dbo.TopProductStats(@StartDate, @EndDate);

SELECT * FROM [dbo].[ORDERS];



DROP FUNCTION IF EXISTS TopProductStats; -- Для видалення функції
