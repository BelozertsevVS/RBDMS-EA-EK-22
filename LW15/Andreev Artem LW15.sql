/* Завдання 1
Напишіть запит, який поверне ідентифікатор клієнта (CUST_NUM) з найбільшим кредитним лімітом (CREDIT_LIMIT).
Враховуйте ймовірність того, що одразу кілька клієнтів можуть мати однаковий кредитний ліміт.
- Використовується таблиця [dbo].[CUSTOMERS]
- Не використовуйте оператор with ties
- Результативний набір даних містить: Ідентифікатор клієнта
*/
SELECT TOP 1 
    CUST_NUM
FROM 
    dbo.CUSTOMERS
WHERE 
    CREDIT_LIMIT = (SELECT MAX(CREDIT_LIMIT) FROM dbo.CUSTOMERS);

/* Завдання 2
Напишіть запит, що повертає список замовлень клієнта з найбільшим кредитним лімітом (CREDIT_LIMIT).
Враховуйте ймовірність того, що одразу кілька клієнтів можуть мати однаковий кредитний ліміт.
- Використовується таблиці [dbo].[CUSTOMERS], [dbo].[ORDERS]
- Не використовуйте оператор with ties
- Результативний набір даних містить: Ідентифікатор клієнта
*/
SELECT TOP 1 
    C.[CUST_NUM]
FROM 
    [dbo].[ORDERS] O
JOIN (SELECT C.[CUST_NUM], C.[CREDIT_LIMIT]
      FROM [dbo].[CUSTOMERS] C
      WHERE C.[CREDIT_LIMIT] = (
      SELECT MAX([CREDIT_LIMIT])
      FROM [dbo].[CUSTOMERS])) C 
      ON O.CUST = C.CUST_NUM;

/* Завдання 3
Напишіть запит, що повертає найновіше (за датою проведення ORDER_DATE) замовлення серед списку замовлень клієнта з найбільшим кредитним лімітом (CREDIT_LIMIT).
Враховуйте ймовірність того, що одразу кілька замовлень можуть мати однакову дату проведення.
Враховуйте ймовірність того, що одразу кілька клієнтів можуть мати однаковий кредитний ліміт.
- Використовується таблиці [dbo].[CUSTOMERS], [dbo].[ORDERS]
- Не використовуйте оператор with ties
- Результативний набір даних містить: Ідентифікатор клієнта
*/
SELECT TOP 1 C.CUST_NUM
FROM dbo.CUSTOMERS C
JOIN dbo.ORDERS O ON C.CUST_NUM = O.CUST
WHERE C.CREDIT_LIMIT = (
    SELECT MAX(CREDIT_LIMIT)
    FROM dbo.CUSTOMERS
);