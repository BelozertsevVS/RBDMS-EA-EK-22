/*
Напишіть запит, який поверне список ідентифікаторів виробників (без дублікатів).
Враховуйте тільки замовлення, що були проведені у 2008 році.
- Використовується таблиця [dbo].[ORDERS]
- Залучіть функцію Year
- Результативний набір даних містить: Ідентифікатор виробника
- Відсортуйте результативний набір даних за Ідентифікатор виробника (за зростанням)
*/
--Виконання завдання:
SELECT DISTINCT MFR
FROM [dbo].[ORDERS]
WHERE YEAR(ORDER_DATE) = 2008
ORDER BY MFR ASC;
--Завдання виконано.

/*
Напишіть запит, який у розрізі кількості відпрацьованих років (математична різниця в роках) поверне кількість працівників.
- Використовується таблиця [dbo].[SALESREPS]
- Результативний набір даних містить: Кількість років, кількість працівників
- Відсортуйте результат за кількістю працівників за зменшенням
*/
--Виконання завдання:
SELECT DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS Years_Worked,
       COUNT(*) AS Number_Of_Employees
FROM [dbo].[SALESREPS]
GROUP BY DATEDIFF(YEAR, HIRE_DATE, GETDATE())
ORDER BY Number_Of_Employees DESC;
--Завдання виконано.

/*
Напишіть запит, який поверне період (рік, місяць) найму з найбільшою кількістю працівників.
Враховуйте ймовірність того, що відразу кілька періодів можуть мати однакову кількість працівників.
- Використовується таблиця [dbo].[SALESREPS]
- Залучіть функції: Year, Month
- Результативний набір даних містить: Рік найму, місяць найму, кількість найнятих працівників
*/
--Виконання завдання:
WITH EmployeeCounts AS (
    SELECT
        YEAR(HIRE_DATE) AS Hire_Year,
        MONTH(HIRE_DATE) AS Hire_Month,
        COUNT(*) AS Num_Employees
    FROM [dbo].[SALESREPS]
    GROUP BY
        YEAR(HIRE_DATE),
        MONTH(HIRE_DATE)
)
SELECT TOP 1 WITH TIES
    Hire_Year,
    Hire_Month,
    Num_Employees
FROM  EmployeeCounts
ORDER BY  Num_Employees DESC;
--Завдання виконано.

/*
Напишіть запит, який у розрізі дня тижня (у строковому представленні) поверне кількість унікальних замовлень, загальну суму продаж, загальну кількість проданих од. товару (за весь час).
Враховуйте тільки замовлення, що були проведені в зимові місяці.
- Використовується таблиця [dbo].[ORDERS]
- Результативний набір даних містить: Номер дня тижня, назву дня тижня,
загальну кількість проведених замовлень, загальну суму продаж, загальну кількість проданих од. товару.
- Відсортуйте результат за днем тижня (за зростанням).
(Культура нумерації днів тижня значення не має)
*/

-- Query to get the number of unique orders, total sales, and total number of products sold for each day of the week,
-- for orders placed in the winter months

--Виконання завдання:
SELECT 
    DATEPART(WEEKDAY, ORDER_DATE) AS Day_Of_Week_Number,
    DATENAME(WEEKDAY, ORDER_DATE) AS Day_Of_Week_Name,
    COUNT(DISTINCT ORDER_NUM) AS Unique_Orders_Count,
    SUM(AMOUNT) AS Total_Sales_Amount,
    SUM(QTY) AS Total_Quantity_Sold
FROM dbo.ORDERS
WHERE MONTH(ORDER_DATE) IN (12, 1, 2) 
GROUP BY DATEPART(WEEKDAY, ORDER_DATE), DATENAME(WEEKDAY, ORDER_DATE)
ORDER BY Day_Of_Week_Number;
--Завдання виконано.