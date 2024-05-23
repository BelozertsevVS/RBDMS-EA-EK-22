USE WebStor;

/*Завдання 1
Напишіть запит, який поверне список ідентифікаторів виробників та ідентифікаторів товарів без дублікатів.
Для відсікання дублікатів необхідно задіяти функцію ранжування ROW_NUMBER.
- Використовується таблиця ORDERS
- Не використовуйте оператор DISTINCT
- Результуючий набір даних містить: ідентифікатори виробників та ідентифікатори товарів
*/

WITH RankedOrders AS (
    SELECT 
        [MFR],
        [PRODUCT],
        ROW_NUMBER() OVER (PARTITION BY [MFR], [PRODUCT] ORDER BY (SELECT NULL)) AS RowNum
    FROM [dbo].[ORDERS]
)
SELECT [MFR], [PRODUCT]
FROM RankedOrders
WHERE RowNum = 1;


/*Завдання 2
Напишіть запит, що повертає список замовлень на товари, які продавалися більше одного разу (за кількістю замовлень на <MFR>, <PRODUCT>).
- Використовується таблиця ORDERS
- Задійте функції ранжування для визначення товарів, які продавалися більше одного разу
*/

WITH OrderCounts AS (
    SELECT 
        [MFR],
        [PRODUCT],
        COUNT(*) AS OrderCount
    FROM [dbo].[ORDERS]
    GROUP BY [MFR], [PRODUCT]
),
FrequentOrders AS (
    SELECT 
        [MFR],
        [PRODUCT]
    FROM OrderCounts
    WHERE OrderCount > 1
)
SELECT 
    o.ORDER_NUM,
    o.MFR,
    o.PRODUCT
FROM [dbo].[ORDERS] o
JOIN FrequentOrders fo ON o.MFR = fo.MFR AND o.PRODUCT = fo.PRODUCT;

/*Завдання 3
Напишіть запит, який для кожної окремої посади поверне найбільш досвідченого працівника (за кількістю відпрацьованих років).
Враховуйте ймовірність того, що одразу кілька працівників мають однаковий стаж.
Розрахуйте кількість відпрацьованих років за допомогою функції DATEDIFF.
Визначте найбільш досвідчених працівників для кожної окремої посади за допомогою функції ранжування DENSE_RANK.
- Використовується таблиця [dbo].[SALESREPS]
*/

WITH RankedSalesReps AS (
    SELECT 
        [TITLE],
        [REP_OFFICE],
        [NAME],
        [HIRE_DATE],
        DATEDIFF(YEAR, [HIRE_DATE], GETDATE()) AS YearsWorked,
        DENSE_RANK() OVER (PARTITION BY [TITLE] ORDER BY DATEDIFF(YEAR, [HIRE_DATE], GETDATE()) DESC) AS Rank
    FROM [dbo].[SALESREPS]
)
SELECT 
    [TITLE],
    [REP_OFFICE],
    [NAME],
    [HIRE_DATE],
    YearsWorked
FROM RankedSalesReps
WHERE Rank = 1;