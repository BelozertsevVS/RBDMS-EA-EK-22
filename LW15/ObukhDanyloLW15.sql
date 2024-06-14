/*Задача 1
Напишіть запит, який поверне ідентифікатор клієнта (CUST_NUM) з найбільшим кредитним лімітом (CREDIT_LIMIT).
Враховуйте ймовірність того, що одразу кілька клієнтів можуть мати однаковий кредитний ліміт.
- Використовується таблиця [dbo].[CUSTOMERS]
- Не використовуйте оператор with ties
- Результативний набір даних містить: Ідентифікатор клієнта*/

SELECT [CUST_NUM] 
FROM [dbo].[CUSTOMERS] cs 
WHERE cs.[CREDIT_LIMIT] = (SELECT MAX([CREDIT_LIMIT]) c
FROM [dbo].[CUSTOMERS] c);

/*Задача 2
Напишіть запит, що повертає список замовлень клієнта з найбільшим кредитним лімітом (CREDIT_LIMIT).
Враховуйте ймовірність того, що одразу кілька клієнтів можуть мати однаковий кредитний ліміт.
- Використовується таблиці [dbo].[CUSTOMERS], [dbo].[ORDERS]
- Не використовуйте оператор with ties
- Результативний набір даних містить: Ідентифікатор клієнта*/

SELECT o.[CUST], o.[ORDER_NUM]
FROM [dbo].[ORDERS] o
JOIN [dbo].[CUSTOMERS] c ON o.[CUST] = c.[CUST_NUM]
WHERE c.[CREDIT_LIMIT] = (SELECT MAX([CREDIT_LIMIT]) cs
FROM [dbo].[CUSTOMERS] cs );

/*Задача 3
Напишіть запит, що повертає найновіше (за датою проведення ORDER_DATE)
замовлення серед списку замовлень клієнта з найбільшим кредитним лімітом (CREDIT_LIMIT).
Враховуйте ймовірність того, що одразу кілька замовлень можуть мати однакову дату проведення.
Враховуйте ймовірність того, що одразу кілька клієнтів можуть мати однаковий кредитний ліміт.
- Використовується таблиці [dbo].[CUSTOMERS], [dbo].[ORDERS]
- Не використовуйте оператор with ties
- Результативний набір даних містить: Ідентифікатор клієнта*/

SELECT TOP 1 o.[CUST]
FROM [dbo].[ORDERS] o
JOIN [dbo].[CUSTOMERS] c ON o.[CUST] = c.[CUST_NUM]
WHERE c.[CREDIT_LIMIT] = (SELECT MAX([CREDIT_LIMIT]) cs
FROM [dbo].[CUSTOMERS] cs)
ORDER BY o.[ORDER_DATE] DESC;