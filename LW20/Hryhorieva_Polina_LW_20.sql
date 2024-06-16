USE WebStor;
/*
Завдання 1
Напишіть запит, який поверне список ідентифікаторів виробників та 
ідентифікаторів товарів без дублікатів.
Для відсікання дублікатів необхідно задіяти функцію ранжування ROW_NUMBER.
- Використовується таблиця ORDERS
- Не використовуйте оператор DISTINCT
- Результуючий набір даних містить: ідентифікатори виробників та ідентифікатори товарів
*/
SELECT MFR, PRODUCT 
FROM (
    SELECT MFR, PRODUCT,
           ROW_NUMBER() OVER(PARTITION BY MFR, PRODUCT 
		                     ORDER BY MFR, PRODUCT) AS rn
    FROM ORDERS
) AS ranked
WHERE rn = 1;
/*
Завдання 2
Напишіть запит, що повертає список замовлень на товари, які продавалися більше одного
разу (за кількістю замовлень на <MFR>, <PRODUCT>).
- Використовується таблиця ORDERS
- Задійте функції ранжування для визначення товарів, які продавалися більше одного разу
*/
WITH Ranked_Orders AS (
    SELECT
        PRODUCT, CUST,
        ROW_NUMBER() OVER (PARTITION BY PRODUCT, CUST ORDER BY ORDER_NUM) AS rn
    FROM
        ORDERS
)
SELECT PRODUCT, CUST
FROM
    Ranked_Orders
WHERE
    rn > 1;
/*
Завдання 3
Напишіть запит, який для кожної окремої посади поверне найбільш досвідченого працівника 
(за кількістю відпрацьованих років).
Враховуйте ймовірність того, що одразу кілька працівників мають однаковий стаж.
Розрахуйте кількість відпрацьованих років за допомогою функції DATEDIFF.
Визначте найбільш досвідчених працівників для кожної окремої посади за допомогою функції 
ранжування DENSE_RANK.
- Використовується таблиця [dbo].[SALESREPS]
*/
WITH RankedEmployees AS (
    SELECT EMPL_NUM, NAME,
        DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS Years_of_work,
        DENSE_RANK() OVER (PARTITION BY TITLE ORDER BY DATEDIFF(YEAR, HIRE_DATE, GETDATE()) DESC) AS Experience_rank
    FROM
        [dbo].[SALESREPS]
)
SELECT
    EMPL_NUM,
    NAME,
    Years_of_work
FROM
    RankedEmployees
WHERE
    Experience_rank = 1;