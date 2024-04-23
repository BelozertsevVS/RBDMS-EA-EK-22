Use WebStor;

/*Завдання 1
Напишіть запит, який поверне список унікальних ідентифікаторів виробників товару (MFR).
Враховуйте лише замовлення, які були проведені у 2008 році клієнтами зі словом CORP у назві (COMPANY). Для цього необхідно використовувати оператор LIKE та підстановочні знаки (wildcards).
- Використовуються таблиці: dbo.CUSTOMERS, dbo.ORDERS
- Застосуйте внутрішнє з'єднання (ANSI-92)
- Результуючий набір даних містить: Ідентифікатор виробника товару (без дублікатів)
*/

SELECT * FROM [dbo].[CUSTOMERS];
SELECT * FROM [dbo].[ORDERS];

SELECT DISTINCT o.MFR
FROM [dbo].[CUSTOMERS] c
JOIN [dbo].[ORDERS] o ON c.CUST_NUM = o.CUST
WHERE O.ORDER_DATE >= '2008-01-01' AND o.ORDER_DATE <= '2008-12-31'
AND c.COMPANY LIKE '%CORP%'
;


/*Завдання 2
Напишіть запит, який у розрізі ідентифікатора клієнта (CUST_NUM) та місяця проведення замовлення (ORDER_DATE) поверне кількість унікальних замовлень (для цього використовується GROUP BY). Враховуйте лише замовлення, які були проведені у 2008 році клієнтами зі словом CORP. у назві (COMPANY). У випадку, якщо у клієнта не було жодного замовлення, залиште такого клієнта у результуючому наборі даних.
Відсортуйте результативний набір даних за кількістю проведених замовлень (за спаданням)
- Використовуються таблиці: dbo.CUSTOMERS, dbo.ORDERS
- Застосуйте ліве зовнішнє з'єднання
- Результуючий набір даних містить: ідентифікатор клієнта, місяць проведення замовлення (для отримання місяця з дати замовлення використовуємо функцію MONTH), кількість унікальних замовлень (використовуємо COUNT)
*/

SELECT * FROM [dbo].[CUSTOMERS];
SELECT * FROM [dbo].[ORDERS];

SELECT c.CUST_NUM
      , MONTH(o.ORDER_DATE) AS ORDER_MONTH
	  , COUNT(DISTINCT o.ORDER_NUM) AS ORDER_COUNT
FROM [dbo].[CUSTOMERS] c 
        LEFT JOIN [dbo].[ORDERS] o ON c.CUST_NUM = o.CUST
WHERE o.ORDER_DATE >= '2008-01-01' AND o.ORDER_DATE <= '2008-12-31'
        AND c.COMPANY LIKE '%CORP%'
GROUP BY c.CUST_NUM, MONTH(o.ORDER_DATE)
ORDER BY ORDER_COUNT DESC
;


/*Завдання 3
Напишіть запит, який поверне список (без дублікатів) придбаних товарів. 
Враховуйте лише замовлення, які були проведені у 2008 році клієнтами зі словом CORP у назві (COMPANY). У випадку, якщо у клієнта не було жодного замовлення, залиште такого клієнта у результуючому наборі даних.
- Використовуються таблиці: dbo.CUSTOMERS, dbo.ORDERS, dbo.PRODUCTS
- Застосуйте ліве зовнішнє з'єднання
- Результуючий набір даних містить: Ідентифікатор клієнта, назва компанії (у верхньому регістрі. Для цього використовуємо рядкову функцію (String Function) UPPER), опис товару ([DESCRIPTION])
*/

SELECT * FROM [dbo].[CUSTOMERS];
SELECT * FROM [dbo].[ORDERS];
SELECT * FROM [dbo].[PRODUCTS];


SELECT DISTINCT c.CUST_NUM
    , UPPER(c.COMPANY) AS COMPANY_NAME, p.[DESCRIPTION]
FROM [dbo].[CUSTOMERS] c
     LEFT JOIN [dbo].[ORDERS] o ON c.CUST_NUM = o.CUST
     LEFT JOIN [dbo].[PRODUCTS] p ON o.PRODUCT = p.PRODUCT_ID
WHERE o.ORDER_DATE >= '2008-01-01' AND o.ORDER_DATE <= '2008-12-31'
AND c.COMPANY LIKE '%CORP%'
;
