/*Завдання 1
Створіть користувацьку скалярну функцію, яка приймає ідентифікатор клієнта як вхідний параметр і повертає ідентифікатор найновішого замовлення клієнта.*/

CREATE FUNCTION dbo.LATEST_ORDER (@CustomerID INT)
RETURNS INT AS BEGIN
DECLARE @LATEST_ORDER INT;

SELECT TOP 1 @LATEST_ORDER = [ORDER_NUM]
FROM [dbo].[ORDERS]
WHERE [CUST] = @CustomerID
ORDER BY [ORDER_DATE] DESC;
RETURN @LATEST_ORDER;
END;
GO

SELECT * FROM  [dbo].[ORDERS];
GO 

DECLARE @CustomerID INT = 2111;
DECLARE @LatestOrderID INT;
SET @LatestOrderID = dbo.LatestOrderID(@CustomerID);
SELECT @LatestOrderID AS LatestOrderID;
GO

/*Завдання 2
Створіть користувацьку inline функцію, яка приймає на вхід параметри: дата початку періоду та дата кінця періоду. 
Функція повертає дані продукту з найбільшою середньою кількістю проданих одиниць товару за період.*/

CREATE FUNCTION Inline_function(@start_date DATE, @end_date DATE)
RETURNS TABLE AS RETURN 
(SELECT TOP 1 [PRODUCT],AVG(QTY) AS [AVERAGE_QTY] 
FROM [dbo].[ORDERS]
WHERE [ORDER_DATE] BETWEEN @start_date AND @end_date 
GROUP BY [PRODUCT] 
ORDER BY [AVERAGE_QTY] DESC);

DECLARE @start_date DATE = '2007-10-12', @end_date DATE = '2008-02-17';
SELECT * FROM [dbo].[ORDERS]
SELECT * FROM dbo.Inline_function(@start_date, @end_date);

/*Завдання 3
Створіть користувацьку Multi-statement функцію, яка приймає на вхід параметри: дата початку періоду та дата кінця періоду. 
Функція повертає дані продукту з найбільшою середньою кількістю проданих одиниць товару, 
з найбільшою середньою сумою продажів і з найбільшою кількістю проведених замовлень за період.*/

CREATE FUNCTION Multi_statement (@start_date DATE, @end_date DATE)
RETURNS @Сolumn TABLE 
(PR_ID CHAR(10),
AVG_QTY DECIMAL(10, 2),
AVG_SALES DECIMAL(10, 2),
ORDER_COUNT INT)

AS BEGIN 
INSERT INTO @Сolumn (PR_ID, AVG_QTY, AVG_SALES, ORDER_COUNT)
SELECT TOP 1 WITH TIES [PRODUCT],
AVG([QTY]) AS AVG_QTY,
AVG([QTY] * [AMOUNT]) AS AVG_SALES,
COUNT(DISTINCT [ORDER_NUM]) AS ORDER_COUNT
FROM [dbo].[ORDERS] WHERE ORDER_DATE BETWEEN @start_date AND @end_date
GROUP BY [PRODUCT]
ORDER BY AVG_QTY DESC, 
AVG_SALES DESC,
ORDER_COUNT DESC;
RETURN;
END;

SELECT * FROM [dbo].[ORDERS]
SELECT * FROM dbo.Multi_statement ('2007-10-12', '2008-02-17');