USE WebStor;

/*Задача 1
Напишіть запит, який поверне ідентифікатор клієнта (CUST_NUM) з найбільшим кредитним лімітом (CREDIT_LIMIT).
Враховуйте ймовірність того, що одразу кілька клієнтів можуть мати однаковий кредитний ліміт.
- Використовується таблиця [dbo].[CUSTOMERS]
- Не використовуйте оператор with ties
- Результативний набір даних містить: Ідентифікатор клієнта
*/
SELECT * FROM [dbo].[CUSTOMERS];

SELECT [CUST_NUM]
  FROM [dbo].[CUSTOMERS]
WHERE  [CREDIT_LIMIT] = (
    SELECT MAX([CREDIT_LIMIT])
    FROM [dbo].[CUSTOMERS]
);

/*Задача 2
Напишіть запит, що повертає список замовлень клієнта з найбільшим кредитним лімітом (CREDIT_LIMIT).
Враховуйте ймовірність того, що одразу кілька клієнтів можуть мати однаковий кредитний ліміт.
- Використовується таблиці [dbo].[CUSTOMERS], [dbo].[ORDERS]
- Не використовуйте оператор with ties
- Результативний набір даних містить: Ідентифікатор клієнта
*/
SELECT * FROM [dbo].[CUSTOMERS];
SELECT * FROM [dbo].[ORDERS];

SELECT c.CUST_NUM
FROM 
[dbo].[ORDERS] o
JOIN (
    SELECT c.CUST_NUM
    FROM [dbo].[CUSTOMERS] c
    WHERE c.CREDIT_LIMIT = (
        SELECT MAX(c.CREDIT_LIMIT)
        FROM [dbo].[CUSTOMERS] c
    )
) c ON o.CUST = c.CUST_NUM
;

/*Задача 3
Напишіть запит, що повертає найновіше (за датою проведення ORDER_DATE) замовлення серед списку замовлень клієнта з найбільшим кредитним лімітом (CREDIT_LIMIT).
Враховуйте ймовірність того, що одразу кілька замовлень можуть мати однакову дату проведення.
Враховуйте ймовірність того, що одразу кілька клієнтів можуть мати однаковий кредитний ліміт.
- Використовується таблиці [dbo].[CUSTOMERS], [dbo].[ORDERS]
- Не використовуйте оператор with ties
- Результативний набір даних містить: Ідентифікатор клієнта
*/

SELECT * FROM [dbo].[CUSTOMERS];
SELECT * FROM [dbo].[ORDERS];

SELECT TOP 1 c.CUST_NUM
FROM [dbo].[ORDERS] o
JOIN (
    SELECT c.CUST_NUM
    FROM [dbo].[CUSTOMERS] c
    WHERE c.CREDIT_LIMIT = (
        SELECT MAX(c.CREDIT_LIMIT)
        FROM [dbo].[CUSTOMERS] c
    )
) c ON o.CUST = c.CUST_NUM
ORDER BY o.ORDER_DATE DESC;
