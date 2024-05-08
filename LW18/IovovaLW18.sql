/*Завдання 1
Створіть користувацьку скалярну функцію, яка приймає ідентифікатор клієнта як вхідний параметр і повертає ідентифікатор найновішого замовлення клієнта.
*/
--Виконання завдання:
CREATE FUNCTION GetLatestOrderID (@CustomerID INT)
RETURNS INT
AS
BEGIN
    DECLARE @LatestOrderID INT;
    SELECT @LatestOrderID = MAX(ORDER_NUM)
    FROM Orders
    WHERE CUST = @CustomerID;
    RETURN @LatestOrderID;
END;
--Перевіримо на справність:
DECLARE @CustomerID INT = 2107; -- Припустимо, що 2107 - це ідентифікатор клієнта, для якого ви хочете отримати останнє замовлення
-- Викликаємо функцію та зберігаємо результат у змінну
DECLARE @LatestOrderID INT;
SET @LatestOrderID = dbo.GetLatestOrderID(@CustomerID);
-- Виводимо результат
SELECT @LatestOrderID AS LatestOrderID;
--Завдання виконано.
/*Завдання 2
Створіть користувацьку inline функцію, яка приймає на вхід параметри: дата початку періоду та дата кінця періоду. Функція повертає дані продукту з найбільшою середньою кількістю проданих одиниць товару за період.
*/
--Виконання завдання:
CREATE FUNCTION GetProductWithHighestAvgSales (
    @StartDate DATE,
    @EndDate DATE
)
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 1
        Product,
        AVG(Qty) AS AvgQuantity
    FROM
        ORDERS
    WHERE
        ORDER_DATE BETWEEN @StartDate AND @EndDate
    GROUP BY
        Product
    ORDER BY
        AVG(Qty) DESC
);
--Перевіримо на справність:
-- Викликаємо функцію та передаємо параметри дати:
SELECT *
FROM dbo.GetProductWithHighestAvgSales('2007-12-31', '2008-01-25');
--Завдання виконано.
/*Завдання 3
Створіть користувацьку Multi-statement функцію, яка приймає на вхід параметри: дата початку періоду та дата кінця періоду. Функція повертає дані продукту з найбільшою середньою кількістю проданих одиниць товару, з найбільшою середньою сумою продажів і з найбільшою кількістю проведених замовлень за період.
*/
--Виконання завдання:
CREATE FUNCTION GetTopProductInfo (
    @StartDate DATE,
    @EndDate DATE
)
RETURNS @TopProducts TABLE (
    ProductID INT,
    AvgQuantity DECIMAL(10, 2),
    AvgSalesAmount DECIMAL(10, 2),
    OrderCount INT
)
AS
BEGIN
    INSERT INTO @TopProducts (ProductID, AvgQuantity, AvgSalesAmount, OrderCount)
    SELECT TOP 1 WITH TIES
        PRODUCT,
        AVG(QTY) AS AvgQuantity,
        AVG(QTY * AMOUNT) AS AvgSalesAmount,
        COUNT(DISTINCT ORDER_NUM) AS OrderCount
    FROM
        ORDERS
    WHERE
        ORDER_DATE BETWEEN @StartDate AND @EndDate
    GROUP BY
        PRODUCT
    ORDER BY
        AVG(QTY) DESC, 
        AVG(QTY * AMOUNT) DESC,
        COUNT(DISTINCT ORDER_NUM) DESC;
    RETURN;
END;
--Перевіримо на справність:
-- Викликаємо функцію та передаємо параметри дати:
SELECT *
FROM dbo.GetTopProductInfo ('2007-12-31', '2008-01-25');
--Завдання виконано.